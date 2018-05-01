require 'rails_helper'

describe "Animals API" do
  it "sends a list of animals" do
    create_list(:animal, 3)

    get "/api/v1/animals"

    expect(response).to be_success

    animals = JSON.parse(response.body)

    expect(animals.count).to eq(3)
  end

  it "sends one animal" do
    animal = create(:animal)

    get "/api/v1/animals/#{animal.id}"

    expect(response).to be_success

    returned_animal = JSON.parse(response.body)

    expect(returned_animal["name"]).to eq(animal.name)
  end

  it "can create a new animal" do
    animal = { name: "billy", breed: "goat" }

    post "/api/v1/animals", params: { animal: animal }

    new_animal = Animal.last

    expect(response).to be_success
    expect(new_animal.name).to eq(animal[:name])
    expect(new_animal.breed).to eq(animal[:breed])
  end

  it "can update an animal" do
    animal = Animal.create(name: "billy", breed: "goat")
    id = animal.id
    old_name = animal.name
    animal_params = { name: "Sledge" }

    put "/api/v1/animals/#{id}", params: { animal: animal_params }

    updated_animal = Animal.find(id)

    expect(response).to be_success

    expect(updated_animal.name).to_not eq(old_name)
    expect(updated_animal.name).to eq("Sledge")
  end
end
