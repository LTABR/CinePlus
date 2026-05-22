/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.pagamento;

/**
 *
 * @author lucas
 */
public abstract class PagamentoModel {
    protected int id;

    public int getId() {
        return id;
    }

    public abstract String getFormaPagamento();
}