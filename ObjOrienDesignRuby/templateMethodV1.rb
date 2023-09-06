=begin
templateMethodV1.rb
Template method design pattern.
Based on Chapter 3 of 'Design Patterns in Ruby'
by Russ Olsen.
M. Laszlo
=end

# Generating an HTML report from title and text.

class HTMLReport
    def initialize(title, text)
        @title = title
        @text = text
    end

    def output_report
        output_start
        output_head
        output_body_start
        output_body
        output_body_end
        output_end
    end

    def output_start
        puts('<html>')
    end

    def output_head
        puts('  <head>')
        puts("    <title>#{@title}</title>")
        puts('  </head>')
    end

    def output_body_start
        puts('  <body>')
    end

    def output_body
        @text.split(/\n/).each do |line|
            puts("    <p>#{line}</p>")
        end
    end

    def output_body_end
        puts('  </body>')
    end

    def output_end
        puts('</html>')
    end
end


msg = %Q{This has been a really\ngood year for all of us!\n}
report = HTMLReport.new('Our report', msg)
report.output_report

=begin
<html>
  <head>
    <title>Our report</title>
  </head>
  <body>
    <p>This has been a really</p>
    <p>good year for all of us!</p>
  </body>
</html>
=end