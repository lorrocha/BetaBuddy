require 'spec_helper'

describe Contact do
  let(:blanks) {['', nil]}

  it {should have_valid(:first_name).when('Bob')}
  it {should_not have_valid(:first_name).when(*blanks)}

  it {should have_valid(:last_name).when('Bob')}
  it {should_not have_valid(:last_name).when(*blanks)}

  it {should have_valid(:email).when('bob@bob.bob')}
  it {should_not have_valid(:email).when(*blanks)}
  it {should_not have_valid(:email).when('some@some@.com', 'some @ somethome.vo', '123124235sdf', 'ed@com')}

  it {should have_valid(:subject).when('Bob')}
  it {should_not have_valid(:subject).when(*blanks)}

  it {should have_valid(:description).when('Bob')}
  it {should_not have_valid(:description).when(*blanks)}

end
