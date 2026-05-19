<%--
    Document   : TelaIngresso
    Created on : 30 de mar. de 2026, 14:27:36
    Author     : PC
--%>

<%@page import="model.SalaModel" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="model.ClienteModel" %>
<%@page import="model.FilmeModel" %>
<%@page import="model.SessaoModel" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.List" %>
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
    NomesModel ingressoEnum = NomesModel.INGRESSO;
    NomesModel pagamentoEnum = NomesModel.PAGAMENTO;
    ClienteModel cliente = (ClienteModel) request.getAttribute("cliente");
    List<HashMap<String, Object>> opcoes = (List<HashMap<String, Object>>) request.getAttribute("opcoes");
%>

<div class="menu-models">
    <button class="btn-menu">
        📲
    </button>

    <div class="menu-opcoes">
        <%
            for (NomesModel nomeModel : NomesModel.values()) {
                if (nomeModel.getSingular().equals(ingressoEnum.getSingular())) continue;
        %>
        <a href="controle?op=<%out.print(AcoesCommand.CONSULTAR_TODOS.getAcao());%>&model=<%out.print(nomeModel.getSingularSemAcento());%>"><%out.print(nomeModel.getPlural());%></a>
        <%}%>
    </div>
</div>

<div class="main-container">
    <header class="ingresso-header"></header>

    <form method="GET" action="controle" class="ingresso-form">
        <input type="hidden" name="idCliente" value="<%out.print(cliente.getId());%>">
        <input type="hidden" name="model" value="<%out.print(pagamentoEnum.getSingularSemAcento());%>">
        <input type="hidden" name="op" value="<%out.print(AcoesCommand.CONSULTAR_CADASTRO.getAcao());%>">
        <div class="col-client-value">
            <div class="info-group">
                <span class="label-pill">Cliente: <h3><%out.println(cliente.getNome());%></h3></span>
            </div>
        </div>

        <div class="col-sessao">
            <label for="sessao" class="label-pill">Sessão</label>
            <div class="custom-select-wrapper">
                <select id="sessao" name="idSessao" class="input-gold" required>
                    <option value="">
                        <%
                            if (opcoes.isEmpty()) {
                                out.print("Capacidades esgotadas");
                            } else {
                                out.print("Selecione");
                            }
                        %>
                    </option>
                    <%
                        for (HashMap sessaoInfo : opcoes) {
                            SessaoModel sessao = (SessaoModel) sessaoInfo.get("sessao");
                            FilmeModel filme = (FilmeModel) sessaoInfo.get("filme");
                            SalaModel sala = (SalaModel) sessaoInfo.get("sala");
                            String padraoData = "HH:mm (dd/MM/yyyy)";
                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(padraoData);
                    %>
                    <option value="<%out.print(sessao.getId());%>"><%
                        out.print(String.format("\"%s\" - %s vagas na Sala %s às %s", filme.getTitulo(), sala.getCapacidade(), sala.getId(), simpleDateFormat.format(sessao.getDataHora())));%></option>
                    <%}%>
                </select>
                <i class="icon-dropdown">⬇️</i>
            </div>
        </div>

        <div class="col-sessao">
            <label for="tipoPagamento" class="label-pill">Tipo de pagamento</label>
            <div class="custom-select-wrapper">
                <select id="tipoPagamento" name="tipoPagamento" class="input-gold" required>
                    <option value="AVista">A vista</option>
                    <option value="Parcelado">Parcelado</option>
                </select>
                <i class="icon-dropdown">️️⬇️</i>
            </div>
        </div>

        <footer class="action-buttons">
            <a href="controle?model=<%out.print(clienteEnum.getSingularSemAcento());%>&op=<%out.print(AcoesCommand.CONSULTAR_TODOS.getAcao());%>">
                <button type="button" class="btn-ticket">
                    Voltar
                </button>
            </a>
            <a href="controle?model=<%out.print(pagamentoEnum.getSingularSemAcento());%>&op=<%out.print(AcoesCommand.CONSULTAR_CADASTRO.getAcao());%>">
                <button type="submit" class="btn-ticket">
                    Prosseguir para pagamento
                </button>
            </a>
        </footer>
    </form>
</div>
</body>
</html>