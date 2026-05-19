package decorator.pagamento;

import model.pagamento.PagamentoModel;

public class PagamentoParcelado extends PagamentoDecorator {
    private final int parcelas;
    private final double valorParcela;

    public PagamentoParcelado(PagamentoModel pagamentoModel, int parcelas, double valorParcela) {
        super(pagamentoModel);
        this.parcelas = parcelas;
        this.valorParcela = valorParcela;
    }

    public int getParcelas() {
        return parcelas;
    }

    public double getValorParcela() {
        return valorParcela;
    }

    @Override
    public double getValorTotal() {
        return valorParcela * parcelas;
    }
}