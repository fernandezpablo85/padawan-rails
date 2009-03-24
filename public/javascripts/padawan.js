document.observe("dom:loaded",function(){

  row = $('hg_row')

  if (!!row)
    $("row_" + $F(row)).highlight();

});

