<%--
    Document   : TelaIngresso
    Created on : 30 de mar. de 2026, 14:27:36
    Author     : PC
--%>

<%@page import="model.ClienteModel" %>
<%@ page import="util.NomesModel" %>
<%@ page import="util.AcoesCommand" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CinePlus</title>
    <link rel="stylesheet" href="view/style/menuModel.css">
    <link rel="stylesheet" href="view/style/cadastroIngresso.css">
</head>
<body>
<%
    NomesModel clienteEnum = NomesModel.CLIENTE;
    NomesModel pagamentoEnum = NomesModel.PAGAMENTO;
    NomesModel ingressoEnum = NomesModel.INGRESSO;
    String[] formasPagamento = {"Cartão", "Boleto", "Pix"};
    ClienteModel cliente = (ClienteModel) request.getAttribute("cliente");
    int idCliente = Integer.parseInt(request.getParameter("idCliente"));
    int idSessao = Integer.parseInt(request.getParameter("idSessao"));
    String tipoPagamento = request.getParameter("tipoPagamento");
%>

<div class="menu-models">
    <button class="btn-menu">
        📲
    </button>

    <div class="menu-opcoes">
        <%
            for (NomesModel nomeModel : NomesModel.values()) {
                if (nomeModel.getSingular().equals(ingressoEnum.getSingular())) continue;
                if (nomeModel.getSingular().equals(pagamentoEnum.getSingular())) continue;
        %>
        <a href="controle?op=<%out.print(AcoesCommand.CONSULTAR_TODOS.getAcao());%>&model=<%out.print(nomeModel.getSingularSemAcento());%>"><%out.print(nomeModel.getPlural());%></a>
        <%}%>
    </div>
</div>

<div class="main-container">
    <header class="ingresso-header"></header>

    <form method="GET" action="controle" class="ingresso-form">
        <input type="hidden" name="model" value="<%out.print(ingressoEnum.getSingularSemAcento());%>">
        <input type="hidden" name="op" value="<%out.print(AcoesCommand.CADASTRAR.getAcao());%>">
        <input type="hidden" name="idCliente" value="<%out.print(idCliente);%>">
        <input type="hidden" name="idSessao" value="<%out.print(idSessao);%>">
        <input type="hidden" name="tipoPagamento" value="<%out.print(tipoPagamento);%>">
        <div class="col-client-value">
            <div class="info-group">
                <span class="label-pill">Cliente: <h3><%out.println(cliente.getNome());%></h3></span>
            </div>
        </div>

        <div class="col-pagamento">
            <label for="formaPagamento" class="label-pill">Forma de pagamento</label>
            <div class="custom-select-wrapper">
                <select id="formaPagamento" name="formaPagamento" class="input-gold" required>
                    <option value="">Selecione</option>
                    <%
                        for (String formapagamento : formasPagamento) {
                    %>
                    <option value="<%out.print(formapagamento);%>"><%out.print(formapagamento);%></option>
                    <%}%>
                </select>
                <i class="icon-dropdown">️️⬇️</i>
            </div>
        </div>


        <div class="info-group margin-top-20">
            <label for="valor" class="label-pill">Valor (R$)</label>
            <div class="value-wrapper input-gold">
                <input type="number" id="valor" name="valor" placeholder="R$" required min="1" step=".5"
                       class="input-gold-inner"/>
            </div>

            <%if (tipoPagamento.equals("Parcelado")) {%>
                    <div class="info-group margin-top-20">
                        <label for="parcelas" class="label-pill">Parcelas</label>
                        <div class="value-wrapper input-gold">
                            <input type="number" id="parcelas" name="parcelas" placeholder="Parcelas" required min="2" step="1" max="24"
                                   class="input-gold-inner"/>
                        </div>
                    </div>
            <%} else if (tipoPagamento.equals("AVista")) {%>
                <div class="info-group margin-top-20">
                    <label for="meiaEntrada" class="label-pill meiaEntrada">
                        É meia-entrada?
                        <input type="checkbox" id="meiaEntrada" name="meiaEntrada" class="input-gold-inner"/>
                    </label>

                </div>
            <%}%>
        </div>

        <footer class="action-buttons">
            <a href="controle?model=<%out.print(clienteEnum.getSingularSemAcento());%>&op=<%out.print(AcoesCommand.CONSULTAR_TODOS.getAcao());%>">
                <button type="button" class="btn-ticket">
                    Voltar
                </button>
            </a>
            <button type="submit" class="btn-ticket">Confirmar</button>
        </footer>
    </form>
</div>
</body>
</html>