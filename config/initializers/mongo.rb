module MongoSetup
  MongoMapper.config = YAML.load(ERB.new(File.read("#{Rails.root}/config/mongodb.yml")).result)
  MongoMapper.connect(Rails.env)
end