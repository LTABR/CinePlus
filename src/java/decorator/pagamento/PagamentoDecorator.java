package decorator.pagamento;

import model.pagamento.PagamentoModel;

public abstract class PagamentoDecorator extends PagamentoModel {
    protected PagamentoModel pagamentoModel;

    public PagamentoDecorator(PagamentoModel pagamentoModel) {
        this.pagamentoModel = pagamentoModel;
    }

    @Override
    public String getFormaPagamento() {
        return pagamentoModel.getFormaPagamento();
    }

    public abstract double getValorTotal();
}