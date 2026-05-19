package decorator.pagamento;

import model.pagamento.PagamentoModel;

public class PagamentoAVista extends PagamentoDecorator {
    private final boolean meiaEntrada;
    private final double valorTotal;

    public PagamentoAVista(PagamentoModel pagamentoModel, double valorTotal, boolean meiaEntrada) {
        super(pagamentoModel);
        this.meiaEntrada = meiaEntrada;
        this.valorTotal = valorTotal;
    }

    public boolean isMeiaEntrada() {
        return meiaEntrada;
    }

    @Override
    public double getValorTotal() {
        return meiaEntrada ? valorTotal / 2 : valorTotal;
    }
}