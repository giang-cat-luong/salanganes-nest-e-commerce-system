/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cart;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author lequa
 */
public class Cart{

    private Map<String, CartDTO> cart;

    public Cart() {
    }

    public Cart(Map<String, CartDTO> cart) {
        this.cart = cart;
    }

    public Map<String, CartDTO> getCart() {
        return cart;
    }

    public void setCart(Map<String, CartDTO> cart) {
        this.cart = cart;
    }

    public boolean add(CartDTO cartDTO) {
        boolean check = false;
        if (this.cart == null) {
            this.cart = new HashMap<>();
        }
        if (this.cart.containsKey(cartDTO.getProductID())) {
            int nowQuantity = this.cart.get(cartDTO.getProductID()).getQuantity();
            cartDTO.setQuantity(nowQuantity + cartDTO.getQuantity());
        }
        this.cart.put(cartDTO.getProductID(), cartDTO);
        check = true;
        return check;
    }

    public boolean remove(String productID) {
        boolean check = false;
        if (this.cart != null) {
            if (this.cart.containsKey(productID)) {
                this.cart.remove(productID);
                check = true;
            }
        }
        return check;
    }

   }
