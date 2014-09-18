
require "rails_helper"

describe Invoice, "#paid_at" do

  before(:each) do
    @invoice = create(:invoice)
  end

  context "if there is more than one successful charge" do

    it "should return the date of the first successful charge" do
      successful_charge = create(:successful_charge)
      @invoice.charges << successful_charge
      @invoice.charges << create(:successful_charge)

      expect(@invoice.paid_at).to eq(successful_charge.created_at)
    end

  end

  context "if there is no successful charge" do

    it "should return nil" do
      @invoice.charges << create(:unsuccessful_charge)
      @invoice.charges << create(:unsuccessful_charge)

      expect(@invoice.paid_at).to eq(nil)
    end

  end

end

describe Invoice, "#paid?" do

  before(:each) do
    @invoice = create(:invoice)
  end

  context "if there is a successful charge" do

    it "should return true" do
      @invoice.charges << create(:unsuccessful_charge)
      @invoice.charges << create(:unsuccessful_charge)
      @invoice.charges << create(:successful_charge)

      expect(@invoice.paid?).to eq(true)
    end

  end

  context "if there is not a successful charge" do

    it "should return false" do
       @invoice.charges << create(:unsuccessful_charge)
       @invoice.charges << create(:unsuccessful_charge)
       @invoice.charges << create(:unsuccessful_charge)

       expect(@invoice.paid?).to eq(false)
    end

  end

end

describe Invoice, "#calculate_total" do

  before(:each) do
    @invoice = create(:invoice)
  end

  it "should set the total to the total of all of its line_items" do
    single_line_item = create(:single_line_item)
    multiplied_line_item = create(:multiplied_line_item)

    @invoice.line_items << single_line_item
    @invoice.line_items << multiplied_line_item

    expected_total = single_line_item.total + multiplied_line_item.total

    @invoice.send(:calculate_total)

    expect(@invoice.total).to eq(expected_total)
  end

end
