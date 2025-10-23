module Wrapper
  def save
    puts "LOG: Починаю збереження..."
    super # Викликає оригінальний метод .save з класу Article
    puts "LOG: ...збереження завершено."
  end
end

class Article
  prepend Wrapper # <-- Головна відмінність

  def save
    puts "ARTICLE: ...зберігаю в базу..."
  end
end

Article.new.save
#=> LOG: Починаю збереження...
#=> ARTICLE: ...зберігаю в базу...
#=> LOG: ...збереження завершено.


