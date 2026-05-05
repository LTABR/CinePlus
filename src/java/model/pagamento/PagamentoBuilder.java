/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.pagamento;

/**
 *
 * @author lucas
 */
public record PagamentoBuilder(PagamentoModel pagamento) {

    public PagamentoBuilder comId(int id) {
        pagamento.id = id;
        return this;
    }

    public PagamentoBuilder comValor(double valor) {
        pagamento.valor = valor;
        return this;
    }

    public PagamentoModel constroi() {
        return pagamento;
    }
}