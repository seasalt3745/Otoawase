class SearchController < ApplicationController

  def search
    @content = params["search"]["content"]
    @method = params["search"]["method"]
    @records = search_for(@content, @method)
  end

  private

  def search_for(content, method)
	if method == 'perfect'
	  User.where(name: content)
	elsif method == 'forward'
	  User.where('name LIKE ?', content+'%')
	elsif method == 'backward'
	  User.where('name LIKE ?', '%'+content)
	else
	  User.where('name LIKE ?', '%'+content+'%')
	end
  end

end

# .or(User.where(Instrument.find(content).user_id: content))