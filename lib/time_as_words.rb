# Adapted from https://codereview.stackexchange.com/a/165993
module TimeAsWords
  def time_as_words(time)
    parsed = parse_time(time)
    format_time(parsed)
  rescue TypeError => e
    Rollbar.error(e)
    time
  rescue ArgumentError => e
    Rollbar.error(e)
    time
  end

  private

  def parse_time(hhmm)
    matches = hhmm.match(/^([01]\d|2[0-3]):([0-5]\d)/)

    if matches.nil? || matches.length.zero?
      raise ArgumentError, "Input string doesn't match required format: 00:00 - 23:59"
    end

    [matches[1].to_i, matches[2].to_i]
  end

  def hour_fmt(hours)
    @hour_words = {
      1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five',
      6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine', 10 => 'ten',
      11 => 'eleven', 12 => 'twelve'
    }

    case hours
    when 0, 24
      'midnight'
    when 12
      'midday'
    when 1..11
      @hour_words[hours] + ' in the morning'
    when 13..17
      @hour_words[hours - 12] + ' in the afternoon'
    when 18..20
      @hour_words[hours - 12] + ' in the evening'
    else
      @hour_words[hours - 12] + ' at night'
    end
  end

  def minute_fmt(minutes)
    @minute_words = {
      1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five',
      6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine', 10 => 'ten',
      11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen',
      16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen', 19 => 'nineteen',
      20 => 'twenty', 21 => 'twenty-one', 22 => 'twenty-two',
      23 => 'twenty-three', 24 => 'twenty-four', 25 => 'twenty-five',
      26 => 'twenty-six', 27 => 'twenty-seven', 28 => 'twenty-eight',
      29 => 'twenty-nine', 30 => 'thirty', 31 => 'thirty-one',
      32 => 'thirty-two', 33 => 'thirty-three', 34 => 'thirty-four',
      35 => 'thirty-five', 36 => 'thirty-six', 37 => 'thirty-seven',
      38 => 'thirty-eight', 39 => 'thirty-nine', 40 => 'fourty',
      41 => 'fourty-one', 42 => 'fourty-two', 43 => 'fourty-three',
      44 => 'fourty-four', 45 => 'fourty-five', 46 => 'fourty-six',
      47 => 'fourty-seven', 48 => 'fourty-eight', 49 => 'fourty-nine',
      50 => 'fifty', 51 => 'fifty-one', 52 => 'fifty-two',
      53 => 'fifty-three', 54 => 'fifty-four', 55 => 'fifty-five',
      56 => 'fifty-six', 57 => 'fifty-seven', 58 => 'fifty-eight',
      59 => 'fifty-nine', 60 => 'sixty'
    }

    format('%<mins>s %<plural>s', mins: @minute_words[minutes], plural: minutes == 1 ? 'minute' : 'minutes')
  end

  def format_time(hhmm)
    hour = hhmm[0]
    minute = hhmm[1]

    if minute.zero?
      format('%<hour>s', hour: hour_fmt(hour))
    else
      format('%<minutes>s past %<hour>s', minutes: minute_fmt(minute), hour: hour_fmt(hour))
    end
  end
end
