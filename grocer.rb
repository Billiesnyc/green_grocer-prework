def consolidate_cart(cart)
 consolidated_hash = { }
 cart.each do |item|
   item.each do |product, properties|
     if !consolidated_hash[product]
     consolidated_hash[product] = properties 
     consolidated_hash[product][:count] = 1
    else 
      consolidated_hash[product][:count] += 1
    end
  end
 end
 consolidated_hash
end

def apply_coupons(cart, coupons)
holding_hash = {}
  cart.each do |product, info|
    coupons.each do |coupon|
      if coupon[:item] == product && info[:count] >= coupon[:num]
        info[:count] = info[:count] - coupon[:num]
        
      if holding_hash["#{product} W/COUPON"]
        holding_hash["#{product} W/COUPON"][:count] += 1
        
      else
        holding_hash["#{product} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
      end
      end
    end
    holding_hash[product] = info
  end
  holding_hash
end	

def apply_clearance(cart)
  cart.each do |product, info|
  if cart[product][:clearance] == TRUE
  cart[product][:price] -= (cart[product][:price] * 0.2)
else
  cart
end
  end
end

def checkout(cart, coupons)
consolidated_cart = consolidate_cart(cart)
	cart_with_coupons = apply_coupons(consolidated_cart, coupons)
	final_cart = apply_clearance(consolidated_cart)
  total = 0
  final_cart.each do |item, info|
  	total += info[:price] * info[:count]
  end
  if total > 100
  	total *= 0.9
  end
  total
end	end
