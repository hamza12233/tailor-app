json.tailors @tailors.each do |tailor|
  json.partial! 'show.json.jbuilder', { tailor: tailor }
end
json.meta_attributes @meta
