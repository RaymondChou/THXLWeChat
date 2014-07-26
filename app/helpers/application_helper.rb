module ApplicationHelper

  def render_stars(num = 4)
    total = 5
    html  = ''
    num.times do
      html << '<i class="icon active"></i>'
    end

    last = total - num
    if last >= 0
      last.times do
        html << '<i class="icon"></i>'
      end
    end

    html
  end

end
