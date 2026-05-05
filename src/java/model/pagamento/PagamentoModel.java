/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.pagamento;

/**
 *
 * @author lucas
 */
public abstract class PagamentoModel implements IPagamento {
    protected int id;
    protected double valor;

    public int getId() {
        return id;
    }

    public double getValor() {
        return valor;
    }

    public abstract String getFormaPagamento();
}