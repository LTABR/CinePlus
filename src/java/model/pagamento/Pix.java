/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.pagamento;

/**
 *
 * @author lucas
 */
public class Pix extends PagamentoModel {

    @Override
    public String getFormaPagamento() {
        return "Pix";
    }
}