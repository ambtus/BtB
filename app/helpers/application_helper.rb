# frozen_string_literal: true

module ApplicationHelper
  def display(int)
    return '0c' if int.nil?
    return "-#{display(int.abs)}" if int.negative?

    if int < 100
      "#{int}c"
    elsif int.to_s.ends_with?('00')
      number_to_currency(int / 100, strip_insignificant_zeros: true)
    else
      number_to_currency(int.to_f / 100)
    end
  end

  def money_picker(inst)
    pieces = []
    pieces << '$'
    pieces << (number_field_tag 'amount[thousands]', inst.thousands, { min: 0, max: 99 })
    pieces << ','
    pieces << (number_field_tag 'amount[dollars]', inst.dollars, { min: 0, max: 999 })
    pieces << '.'
    pieces << (number_field_tag 'amount[cents]', inst.cents, { min: 0, max: 99 })
    pieces << 'c'
    safe_join pieces
  end
end
