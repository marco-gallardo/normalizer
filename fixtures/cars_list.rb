# This assumes that valid cars makers
# and models are stored somewhere (ie
# database). This list is whitelisting
# valid makers and models.

module CarsList
  CARS_LIST = [
    {
      maker: 'Ford',
      models: [
        'Focus'
      ]
    },
    {
      maker: 'Chevrolet',
      models: [
        'Impala'
      ]
    }
  ].freeze
end
