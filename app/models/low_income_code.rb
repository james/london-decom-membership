class LowIncomeCode < ApplicationRecord
  belongs_to :low_income_request, optional: true
  before_create :set_code

  scope :available, -> { where('low_income_request_id IS NULL') }
  scope :taken, -> { where('low_income_request_id IS NOT NULL') }

  CHARACTER_MAP = {
    '3' => ['3'],
    '4' => ['4'],
    '6' => ['6'],
    '7' => ['7'],
    '8' => ['8'],
    '9' => ['9'],
    'A' => ['A', 'a'],
    'B' => ['B', 'b'],
    'C' => ['C', 'c'],
    'D' => ['D', 'd'],
    'E' => ['E', 'e'],
    'F' => ['F', 'f'],
    'G' => ['G', 'g'],
    'H' => ['H', 'h'],
    'J' => ['J', 'j'],
    'K' => ['K', 'k'],
    'L' => ['L', 'l', '1', 'I', 'i'],
    'M' => ['M', 'm'],
    'N' => ['N', 'n'],
    'O' => ['O', 'o', '0'],
    'P' => ['P', 'p'],
    'Q' => ['Q', 'q'],
    'R' => ['R', 'r'],
    'S' => ['S', 's', '5'],
    'T' => ['T', 't'],
    'U' => ['U', 'u'],
    'V' => ['V', 'v'],
    'W' => ['W', 'w'],
    'X' => ['X', 'x'],
    'Y' => ['Y', 'y'],
    'Z' => ['Z', 'z', '2']
  }.freeze

  STOREABLE_CHARACTER_MAP = CHARACTER_MAP.keys

  def self.create_code(size = 8)
    (0...size).map { STOREABLE_CHARACTER_MAP[Kernel.rand(STOREABLE_CHARACTER_MAP.size)] }.join
  end

  private

  def set_code
    self.code = MembershipCode.create_code
  end
end
