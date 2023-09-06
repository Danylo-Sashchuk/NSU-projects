=begin
templateMethodV4.rb
Template method design pattern.
Based on Chapter 3 of 'Design Patterns in Ruby'
by Russ Olsen.
M. Laszlo
=end

# Here Report implements output_body: It calls output_line
# on each line of text. In turn, output_line prints the
# line. This default behavior is factored from 
# Report#output_body in version 3. Subclasses may override 
# either method if necessary (HTMLReport overrides output_body).
# Note we define a setter and getter for both @title and @text.

class Report
    attr_accessor :title, :text

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
    end

    def output_head
    end

    def output_body_start
    end

    def output_body
        text.split(/\n/).each do |line|
            output_line(line)
        end
    end

    def output_line(line)
        puts(line)
    end

    def output_body_end
    end

    def output_end
    end

end

class TextReport < Report
    def output_head
        puts("**** #{title} ****")
    end
end


class HTMLReport < Report
    def output_start
        puts('<html>')
    end

    def output_head
        puts('  <head>')
        puts("    <title>#{title}</title>")
        puts('  </head>')
    end

    def output_body_start
        puts('  <body>')
    end

    def output_line(line)
        puts("    <p>#{line}</p>")
    end

    def output_body_end
        puts('  </body>')
    end

    def output_end
        puts('</html>')
    end
end


msg = %Q{This has been a really\ngood year for all of us!}
report = HTMLReport.new('Our report', msg)
report.output_report
puts("\n")
text_report = TextReport.new('Our report', msg)
text_report.output_report
puts("\n")
text_report.title = "Our newest report"
text_report.text = "Things are\nstill looking\nreally good for us!"
text_report.output_report

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

**** Our report ****
This has been a really
good year for all of us!

**** Our newest report ****
Things are
still looking
really good for us!
=end