/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package command.pagamento;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.ICommand;
import dao.ClienteDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import model.ClienteModel;

/**
 *
 * @author alunocmc
 */
public class PagamentoConsultarCadastro implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pagina = "view/cadastroPagamento.jsp";

        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        int idSessao = Integer.parseInt(request.getParameter("idSessao"));
        String tipoPagamento = request.getParameter("tipoPagamento");
        request.setAttribute("idCliente", idCliente);
        request.setAttribute("idSessao", idSessao);
        request.setAttribute("tipoPagamento", tipoPagamento);

        ClienteDAO clienteDAO = new ClienteDAO();

        ClienteModel cliente = ClienteModel.getBuilder()
                .comId(idCliente)
                .constroi();
        try {
            ClienteModel resultadoCliente = clienteDAO.consultarById(cliente);
            request.setAttribute("cliente", resultadoCliente);
        } catch (ClassNotFoundException | SQLException | NumberFormatException err) {
            System.out.println("ERRO: " + err);
            request.setAttribute("message", err);
            pagina = "erro.jsp";
        }

        return pagina;
    }
}