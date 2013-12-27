require 'spec_helper'

describe User do
  # Validation checks
  it {should have_valid(:username).when('Fred', 'Sexyschoolgirl')}
  it {should_not have_valid(:username).when(nil, '')}
  it {should have_valid(:encrypted_password).when('Wookie5', 'bloop')}
  it {should_not have_valid(:encrypted_password).when(nil, '')}
  it {should have_valid(:email).when('blank@blank.com', 'supercool.dude@fancy.io', 'fantasy11-!@rightious.co')}
  it {should_not have_valid(:email).when(nil, '', 'hahaha@ah@ha.com', 'yo@yo.com.com', 'poop', 'bro.com', 'singular@single')}
end
