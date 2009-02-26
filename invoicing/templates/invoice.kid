<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>Welcome to TurboGears</title>
</head>
<body>
  <div id="getting_started">
    <p py:if="previous"><a href="${tg.link('invoice','view',previous.id)}"><img src="${tg.url('/static/images/go-previous.png')}" /> Previous Invoice</a></p>
    <p py:if="next" class="right"><a href="${tg.link('invoice','view',next.id)}">Next Invoice <img src="${tg.url('/static/images/go-next.png')}" /></a></p>
    <h3 class="right" py:content="tg.format_date(invoice.date)"></h3>
    <h2 class="right">Status: ${invoice.status}</h2>
    <h3>ATTN: ${invoice.client.billing_person}</h3>
    <p py:content="tg.format_address(invoice.client.address)"></p>
    <p>Invoice number: ${invoice.ident}</p>
    <table class="products">
      <tr>
	<th>DESCRIPTION OF GOODS/SERVICES</th>
	<th>Total</th>
      </tr>
      <tr py:if="invoice.products" py:for="line in invoice.products">
	<td>${line.quantity} x ${line.product.name} (${tg.format_money(line.price)} each)</td>
	<td py:content="tg.format_money(line.total)"></td>
      </tr>
      <tr py:if="not invoice.products">
	<td>No products added to this invoice</td>
	<td></td>
      </tr>
      <tr>
	<td class="right">SUB-TOTAL</td>
	<td>${tg.format_money(invoice.total)}</td>
      </tr>
      <tr>
	<td class="right">VAT (${tg.format_percentage(invoice.vat_rate)})</td>
	<td>${tg.format_money(invoice.vat)}</td>
      </tr>
      <tr>
	<td class="right"><h4>TOTAL</h4></td>
	<td><h4>${tg.format_money(invoice.net_total)}</h4></td>
      </tr>
    </table>
    <p>Payment Term: ${invoice.terms}</p>
    <hr />
    <div class="right">
      <span class="actionIcons">${tg.print_icon(invoice)} ${tg.edit_icon(invoice)} ${tg.delete_icon(invoice)} ${tg.email_icon(invoice)}</span>
    </div>
  </div>
</body>
</html>
