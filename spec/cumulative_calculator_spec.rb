require 'spec_helper'
require 'binomial'

describe "Binomial::CumulativeCalculator" do
  describe "calculate" do
    it "should validate probability is > 0" do
      expect {
        Binomial::CumulativeCalculator.new(
          :trials       => 10,
          :probability  => 0,
          :target       => 3,
          :sign => :greater_than_or_equal_to
        ).calculate
      }.to raise_error
    end

    it "should validate probability is < 1" do
      expect {
        Binomial::CumulativeCalculator.new(
          :trials       => 10,
          :probability  => 1.1,
          :target       => 3,
          :sign => :greater_than_or_equal_to
        ).calculate
      }.to raise_error
    end

    it "should succeed if probability is >0 and <1" do
      expect {
        Binomial::CumulativeCalculator.new(
          :trials       => 10,
          :probability  => 0.2,
          :target       => 3,
          :sign => :greater_than_or_equal_to
        ).calculate
      }.to_not raise_error
    end

    it "should validate target < trials" do
      expect {
        Binomial::CumulativeCalculator.new(
          :trials       => 10,
          :probability  => 0.2,
          :target       => 11,
          :sign => :greater_than_or_equal_to
        ).calculate
      }.to raise_error
    end

    it "should succeed if target < trials" do
      expect {
        Binomial::CumulativeCalculator.new(
          :trials       => 10,
          :probability  => 0.2,
          :target       => 3,
          :sign => :greater_than_or_equal_to
        ).calculate
      }.to_not raise_error
    end

    it "should validate target > 0" do
      expect {
        Binomial::CumulativeCalculator.new(
          :trials       => 10,
          :probability  => 0.2,
          :target       => 0,
          :sign => :greater_than_or_equal_to
        ).calculate
      }.to raise_error
    end

    it "should succeed if target > 0" do
      expect {
        Binomial::CumulativeCalculator.new(
          :trials       => 10,
          :probability  => 0.2,
          :target       => 3,
          :sign => :greater_than_or_equal_to
        ).calculate
      }.to_not raise_error
    end

    it "should produce the correct results" do
      Binomial::CumulativeCalculator.new(
        :trials       => 100,
        :probability  => 0.4,
        :target       => 59,
        :sign => :greater_than_or_equal_to
      ).calculate.should == 0.0001

      Binomial::CumulativeCalculator.new(
        :trials       => 10,
        :probability  => 0.2,
        :target       => 3,
        :sign => :greater_than_or_equal_to
      ).calculate.should == 0.3222
    end
  end
end
