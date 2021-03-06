module Spree
  module Tax
    # Add tax adjustments to all line items and shipments in an order
    class OrderAdjuster
      attr_reader :order

      include TaxHelpers

      # @param [Spree::Order] order to be adjusted
      def initialize(order)
        @order = order
      end

      # Creates tax adjustments for all taxable items (shipments and line items)
      # in the given order.
      def adjust!
        return unless order_tax_zone

        (order.line_items + order.shipments).each do |item|
          ItemAdjuster.new(item, rates_for_order_zone: applicable_rates).adjust!
        end
      end
    end
  end
end
