# --- 1. Визначення Стратегій ---
# Кожна стратегія має однаковий інтерфейс (метод .format)

class TextFormatter
  def format(title, body_lines)
    output = []
    output << "===== #{title} ====="
    output << ""
    output.concat(body_lines)
    output << ""
    output << "Кінець звіту."
    output.join("\n")
  end
end

class MarkdownFormatter
  def format(title, body_lines)
    output = []
    output << "# #{title}"
    output << ""
    body_lines.each do |line|
      output << "* #{line}"
    end
    output.join("\n")
  end
end

class HTMLFormatter
  def format(title, body_lines)
    list_items = body_lines.map { |line| "      <li>#{line}</li>" }.join("\n")

    <<~HTML
      <html>
        <head>
          <title>#{title}</title>
        </head>
        <body>
          <h1>#{title}</h1>
          <ul>
      #{list_items}
          </ul>
        </body>
      </html>
    HTML
  end
end

class Report
  attr_accessor :title, :body_lines, :formatter # Стратегія

  def initialize(title, body_lines)
    @title = title
    @body_lines = body_lines
    @formatter = nil
  end

  # Метод, який делегує роботу поточній стратегії
  def output
    unless @formatter
      raise "Стратегію форматування не встановлено!"
    end

    @formatter.format(@title, @body_lines)
  end
end

# --- Приклад використання ---

report_data = [
  "Продажі: 500 одиниць",
  "Відвідувачі: 1200",
  "Конверсія: 41.6%"
]

report = Report.new("Звіт за Q3", report_data)

report.formatter = TextFormatter.new
puts report.output

puts "\n" + ("=" * 40) + "\n"

report.formatter = MarkdownFormatter.new
puts "--- Звіт у форматі MARKDOWN ---"
puts report.output

puts "\n" + ("=" * 40) + "\n"

# --- Стратегія 3: HTML ---
report.formatter = HTMLFormatter.new
puts "--- Звіт у форматі HTML ---"
puts report.output