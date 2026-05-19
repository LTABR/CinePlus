/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.ingresso;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.ICommand;
import dao.IngressoDAO;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;

import decorator.pagamento.PagamentoAVista;
import decorator.pagamento.PagamentoParcelado;
import model.*;
import model.pagamento.*;

/**
 *
 * @author alunocmc
 */
public class IngressoCadastrar implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "controle?op=ConsultarTodos&model=Cliente";

        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        int idSessao = Integer.parseInt(request.getParameter("idSessao"));
        String formaPagamento = request.getParameter("formaPagamento");
        double valorPagamento = Double.parseDouble(request.getParameter("valor"));
        String tipoPagamento = request.getParameter("tipoPagamento");

        boolean isMeiaEntrada = request.getParameter("meiaEntrada") != null;
        int parcelas = request.getParameter("parcelas") != null ? Integer.parseInt(request.getParameter("parcelas")) : 1;

        IngressoDAO ingressoDAO = new IngressoDAO();

        ClienteModel cliente = ClienteModel.getBuilder()
                .comId(idCliente)
                .constroi();

        SessaoModel sessao = SessaoModel.getBuilder()
                .comId(idSessao)
                .constroi();

        PagamentoModel pagamento = switch (formaPagamento) {
            case "Cartão" -> new Cartao();
            case "Pix" -> new Pix();
            default -> new Boleto();
        };
        pagamento = tipoPagamento.equals("Parcelado") ?
                new PagamentoParcelado(pagamento, parcelas, valorPagamento) :
                new PagamentoAVista(pagamento, valorPagamento, isMeiaEntrada);

        IngressoModel ingresso = IngressoModel.getBuilder()
                .comCliente(cliente)
                .comSessao(sessao)
                .comPagamento(pagamento)
                .constroi();

        try {
            ingressoDAO.cadastrar(ingresso);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            String mensagem = err.toString();
            if (mensagem.contains("fk_ingresso_sessao")) {
                request.setAttribute("message", "Esta sessão não existe.");
            } else {
                System.out.println("ERRO: " + err);
                request.setAttribute("message", err);
            }
            pagina = "erro.jsp";
        }
        return pagina;
    }
}