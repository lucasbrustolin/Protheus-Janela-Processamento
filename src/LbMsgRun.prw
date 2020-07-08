#Include "Protheus.ch"   
#Include 'ParmType.ch'

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} LbMsgRun
@type			: Funcao de usuario
@Sample			: U_LbMsgRun( bAction, cTitle, cText, nStyle, nPosLeft, cSvgCustom) 
@description	: Funcao para a montagem da tela de processmanto semelhante a função padrao FwMsgRun.
                  Possui 8 modelos de carregamento "Load" além de permitir o uso de um modelo customizado.
@parama         : bAction       -> Bloco para inclusao da rotina de processamento.
@parama         : cTitle        -> Titulo da janela 
@parama         : cText         -> Mensagem de processamento (Permite Formatação em HTML)
@parama         : nStyle        -> Modelos SVG (1... à 8)
@parama         : nPosLeft      -> Permite reposicionar o SVG na janela de processamento. Ref. esquerda da janela  (Default Centralizado)
@parama         : cSvgCustom    -> Permite que seja informado um modelo de SVG próprio ignorando os modelos existentes. 
@return			: Nil
@ --------------|----------------
@author			: Lucas.Brustolin
@since			: 08/07/2020
@version		: 12.1.17
/*/
//------------------------------------------------------------------------------------------
User Function  LbMsgRun( bAction, cTitle, cText, nStyle, nPosLeft, cSvgCustom)

Local oDialog       := Nil
Local oSVG          := Nil 
Local oSay          := Nil
Local nLargDlg      := 0
Local nAltDlg       := 0
Local cSvgAnimado   := "" 


PARAMTYPE 0 VAR bAction		AS BLOCK DEFAULT { || Sleep(5000) }
PARAMTYPE 1 VAR cTitle		AS CHARACTER    OPTIONAL DEFAULT "LbMsgRun"
PARAMTYPE 2 VAR cText       AS CHARACTER    OPTIONAL DEFAULT '<span style="color: #003366; size=15">Processando, aguarde...</span>'
PARAMTYPE 3 VAR nStyle		AS NUMERIC      OPTIONAL DEFAULT 1
PARAMTYPE 4 VAR nPosLeft	AS NUMERIC      OPTIONAL DEFAULT 0
PARAMTYPE 5 VAR cSvgCustom	AS CHARACTER    OPTIONAL DEFAULT ""


    nLargDlg := 500
    nAltDlg  := 200

	//---------------------------- +
    // cria Janela de carregamento |
    //---------------------------- + 
	oDialog := FWStyledDialog():New(0,0,nAltDlg,nLargDlg,cTitle,{||})

    // Ajusta a altura da dialog
	oDialog:nHeight := oDialog:nHeight - ( oDialog:nClientHeight - nAltDlg )
	
    //-- Se Carrega SVG do usuario ou nao  
    If Empty( cSvgCustom )
        cSvgAnimado  := GetSvgLoad( nStyle )
    Else 
        cSvgAnimado := cSvgCustom
    EndIf  

    //-- Definição do objeto SVG
    oSVG := TSVG():New(35,0,oDialog,200,200,cSvgAnimado,/*lStretch*/ )

    //-- Esconde a borda do objeto SVG que é adicionado por default 
    oSVG:SetCSS("QWidget{border: none; background: transparent;}")

    //-- Centralizado 
    If ( nPosLeft == 0 )
        nPosLeft   := 40
        nPosLeft   := ( nLargDlg / 2 ) - nPosLeft 
    Else 
        nPosLeft := ( nPosLeft / 2 ) 
    Endif 

    //-- Ajuste do posicionamento do SVG
    oSVG:nLeft := nPosLeft 

	
	// Texto que sera apresentado e atualizado no processamento
  	@ 018, 005 SAY oSay PROMPT cText SIZE nLargDlg / 2, 007 OF oDialog  HTML CENTERED PIXEL
	

	oDialog:Activate(,,,.T.,,, {|| Eval(bAction, oSay), oDialog:End() } )

Return()


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} GetSvgLoad
@type			: Function
@Sample			: GetSvgLoad( 1  )
@description	: Rotina responsável por montar o modelo de carregamento em SVG
@return			: cLoadSVG - SVG
@ --------------|----------------
@author			: Lucas.Brustolin
@since			: 08/07/2020
@version		: 12.1.17
/*/
//------------------------------------------------------------------------------------------
Static Function GetSvgLoad( nType  )

Local cLoadSVG	:= ""

Default nType := 0

    // ------------------------------------+
    // MONTA O SVG ANIAMDO DE CARREGAMENTO |
    // ------------------------------------+

Do Case 

    Case nType == 1

        // -------------------------- +
        // SVG MODELO ESTILO PIZZA    |
        // -------------------------- +
    
        cLoadSVG += '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: none; display: block; shape-rendering: auto;" width="110px" height="110px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">'
        cLoadSVG += '<g transform="translate(50 50)">'
        cLoadSVG += '<g transform="scale(0.7)">'
        cLoadSVG += '    <g transform="translate(-50 -50)">'
        cLoadSVG += '    <g transform="rotate(59.9375 50 50)">'
        cLoadSVG += '        <animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" values="0 50 50;360 50 50" keyTimes="0;1" dur="0.7575757575757576s"></animateTransform>'
        cLoadSVG += '        <path fill-opacity="0.8" fill="#d8232f" d="M50 50L50 0A50 50 0 0 1 100 50Z"></path>'
        cLoadSVG += '    </g>'
        cLoadSVG += '    <g transform="rotate(314.947 50 50)">'
        cLoadSVG += '        <animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" values="0 50 50;360 50 50" keyTimes="0;1" dur="1.0101010101010102s"></animateTransform>'
        cLoadSVG += '        <path fill-opacity="0.8" fill="#e9d831" d="M50 50L50 0A50 50 0 0 1 100 50Z" transform="rotate(90 50 50)"></path>
        cLoadSVG += '    </g>'
        cLoadSVG += '    <g transform="rotate(209.966 50 50)">'
        cLoadSVG += '        <animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" values="0 50 50;360 50 50" keyTimes="0;1" dur="1.5151515151515151s"></animateTransform>'
        cLoadSVG += '        <path fill-opacity="0.8" fill="#48b149" d="M50 50L50 0A50 50 0 0 1 100 50Z" transform="rotate(180 50 50)"></path>'
        cLoadSVG += '    </g>'
        cLoadSVG += '    <g transform="rotate(104.982 50 50)">'
        cLoadSVG += '        <animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" values="0 50 50;360 50 50" keyTimes="0;1" dur="3.0303030303030303s"></animateTransform>'
        cLoadSVG += '        <path fill-opacity="0.8" fill="#4bbfc9" d="M50 50L50 0A50 50 0 0 1 100 50Z" transform="rotate(270 50 50)"></path>'
        cLoadSVG += '    </g>'
        cLoadSVG += '    </g>'
        cLoadSVG += '</g>'
        cLoadSVG += '</g>'
        cLoadSVG += '<!-- [ldio] generated by https://loading.io/ --></svg>'


    Case nType == 2

        // ------------------------------- +
        // SVG MODELO ESTILO ENGRENAGEM    |
        // ------------------------------- +

        cLoadSVG += '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: none; display: block; shape-rendering: auto;" width="104px" height="104px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">'
        cLoadSVG += '<g transform="translate(50 50)">'
        cLoadSVG += '<g transform="rotate(35.6875)">'
        cLoadSVG += '<animateTransform attributeName="transform" type="rotate" values="0;45" keyTimes="0;1" dur="0.2s" repeatCount="indefinite"></animateTransform><path d="M29.491524206117255 -5.5 L37.491524206117255 -5.5 L37.491524206117255 5.5 L29.491524206117255 5.5 A30 30 0 0 1 24.742744050198738 16.964569457146712 L24.742744050198738 16.964569457146712 L30.399598299691117 22.621423706639092 L22.621423706639096 30.399598299691114 L16.964569457146716 24.742744050198734 A30 30 0 0 1 5.5 29.491524206117255 L5.5 29.491524206117255 L5.5 37.491524206117255 L-5.499999999999997 37.491524206117255 L-5.499999999999997 29.491524206117255 A30 30 0 0 1 -16.964569457146705 24.742744050198738 L-16.964569457146705 24.742744050198738 L-22.621423706639085 30.399598299691117 L-30.399598299691117 22.621423706639092 L-24.742744050198738 16.964569457146712 A30 30 0 0 1 -29.491524206117255 5.500000000000009 L-29.491524206117255 5.500000000000009 L-37.491524206117255 5.50000000000001 L-37.491524206117255 -5.500000000000001 L-29.491524206117255 -5.500000000000002 A30 30 0 0 1 -24.742744050198738 -16.964569457146705 L-24.742744050198738 -16.964569457146705 L-30.399598299691117 -22.621423706639085 L-22.621423706639092 -30.399598299691117 L-16.964569457146712 -24.742744050198738 A30 30 0 0 1 -5.500000000000011 -29.491524206117255 L-5.500000000000011 -29.491524206117255 L-5.500000000000012 -37.491524206117255 L5.499999999999998 -37.491524206117255 L5.5 -29.491524206117255 A30 30 0 0 1 16.964569457146702 -24.74274405019874 L16.964569457146702 -24.74274405019874 L22.62142370663908 -30.39959829969112 L30.399598299691117 -22.6214237066391 L24.742744050198738 -16.964569457146716 A30 30 0 0 1 29.491524206117255 -5.500000000000013 M0 -20A20 20 0 1 0 0 20 A20 20 0 1 0 0 -20" fill="#1d5794"></path></g></g>'
        cLoadSVG += '<!-- [ldio] generated by https://loading.io/ --></svg>'

    
    Case nType == 3
        
        // ------------------------------- +
        // SVG MODELO ESTILO BOLA PRETA    |
        // ------------------------------- +

        cLoadSVG += '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: none; display: block; shape-rendering: auto;" width="104px" height="104px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">'
        cLoadSVG += '<g transform="translate(50,50)">'
        cLoadSVG += '<g transform="scale(0.7)">'
        cLoadSVG += '<circle cx="0" cy="0" r="50" fill="#211a1d"></circle>'
        cLoadSVG += '<circle cx="0" cy="-28" r="15" fill="#ffffff" transform="rotate(75.5284)">'
        cLoadSVG += '    <animateTransform attributeName="transform" type="rotate" dur="1s" repeatCount="indefinite" keyTimes="0;1" values="0 0 0;360 0 0"></animateTransform>'
        cLoadSVG += '</circle>'
        cLoadSVG += '</g>'
        cLoadSVG += '</g>'
        cLoadSVG += '<!-- [ldio] generated by https://loading.io/ --></svg>  '      
    
    Case nType == 4        
       
        // ---------------------------------- +
        // SVG MODELO ESTILO BLOCOS COLORIDOS |
        // ---------------------------------- +

        cLoadSVG += '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: none; display: block; shape-rendering: auto;" width="84px" height="84px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">'
        cLoadSVG += '<g transform="translate(28.166666666666664,28.166666666666664)">'
        cLoadSVG += '<rect x="-15.5" y="-15.5" width="31" height="31" fill="#e81120" transform="scale(1.08128 1.08128)">'
        cLoadSVG += '    <animateTransform attributeName="transform" type="scale" repeatCount="indefinite" dur="0.6944444444444443s" keyTimes="0;1" values="1.1500000000000001;1" begin="-0.20833333333333331s"></animateTransform>'
        cLoadSVG += '</rect>'
        cLoadSVG += '</g>'
        cLoadSVG += '<g transform="translate(71.83333333333333,28.166666666666664)">'
        cLoadSVG += '<rect x="-15.5" y="-15.5" width="31" height="31" fill="#e8dc18" transform="scale(1.09628 1.09628)">'
        cLoadSVG += '    <animateTransform attributeName="transform" type="scale" repeatCount="indefinite" dur="0.6944444444444443s" keyTimes="0;1" values="1.1500000000000001;1" begin="-0.13888888888888887s"></animateTransform>'
        cLoadSVG += '</rect>'
        cLoadSVG += '</g>'
        cLoadSVG += '<g transform="translate(28.166666666666664,71.83333333333333)">'
        cLoadSVG += '<rect x="-15.5" y="-15.5" width="31" height="31" fill="#59c25a" transform="scale(1.12628 1.12628)">'
        cLoadSVG += '    <animateTransform attributeName="transform" type="scale" repeatCount="indefinite" dur="0.6944444444444443s" keyTimes="0;1" values="1.1500000000000001;1" begin="0s"></animateTransform>'
        cLoadSVG += '</rect>'
        cLoadSVG += '</g>'
        cLoadSVG += '<g transform="translate(71.83333333333333,71.83333333333333)">'
        cLoadSVG += '<rect x="-15.5" y="-15.5" width="31" height="31" fill="#1b46c6" transform="scale(1.11128 1.11128)">'
        cLoadSVG += '    <animateTransform attributeName="transform" type="scale" repeatCount="indefinite" dur="0.6944444444444443s" keyTimes="0;1" values="1.1500000000000001;1" begin="-0.06944444444444443s"></animateTransform>'
        cLoadSVG += '</rect>'
        cLoadSVG += '</g>'
        cLoadSVG += '<!-- [ldio] generated by https://loading.io/ --></svg>'

    Case nType == 5        

        // -------------------------------- +
        // SVG MODELO ESTILO BALAO WHATSAPP |
        // -------------------------------- +

        cLoadSVG += '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: none; display: block; shape-rendering: auto;" width="100px" height="100px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">'
        cLoadSVG += '<path d="M82 50A32 32 0 1 1 23.533421623214014 32.01333190873183 L21.71572875253809 21.7157287525381 L32.013331908731814 23.53342162321403 A32 32 0 0 1 82 50" stroke-width="5" stroke="#44ae19" fill="none"></path>'
        cLoadSVG += '<circle cx="50" cy="50" r="20" stroke-width="5" stroke="#44ae19" stroke-dasharray="31.41592653589793 31.41592653589793" fill="none" stroke-linecap="round" transform="rotate(76.1702 50 50)">'
        cLoadSVG += '<animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" dur="1s" keyTimes="0;1" values="0 50 50;360 50 50"></animateTransform>'
        cLoadSVG += '</circle>'
        cLoadSVG += '<!-- [ldio] generated by https://loading.io/ --></svg>'

    Case nType == 6        

        // ----------------------------- +
        // SVG MODELO ESTILO DOUBLE RING |
        // ----------------------------- +

        cLoadSVG += '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: none; display: block; shape-rendering: auto;" width="110px" height="110px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">'
        cLoadSVG += '<circle cx="50" cy="50" r="32" stroke-width="8" stroke="#2a637c" stroke-dasharray="50.26548245743669 50.26548245743669" fill="none" stroke-linecap="round" transform="rotate(81.5749 50 50)">'
        cLoadSVG += '<animateTransform attributeName="transform" type="rotate" dur="1s" repeatCount="indefinite" keyTimes="0;1" values="0 50 50;360 50 50"></animateTransform>'
        cLoadSVG += '</circle>'
        cLoadSVG += '<circle cx="50" cy="50" r="23" stroke-width="8" stroke="#4db643" stroke-dasharray="36.12831551628262 36.12831551628262" stroke-dashoffset="36.12831551628262" fill="none" stroke-linecap="round" transform="rotate(-81.5749 50 50)">'
        cLoadSVG += '<animateTransform attributeName="transform" type="rotate" dur="1s" repeatCount="indefinite" keyTimes="0;1" values="0 50 50;-360 50 50"></animateTransform>'
        cLoadSVG += '</circle>'
        cLoadSVG += '<!-- [ldio] generated by https://loading.io/ --></svg>'

    Case nType == 7        

        // ---------------------------------- +
        // SVG MODELO ESTILO LUPA DE PESQUISA |
        // ---------------------------------- +

        cLoadSVG += '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: none; display: block; shape-rendering: auto;" width="110px" height="110px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">'
        cLoadSVG += '<g transform="translate(50 50)">'
        cLoadSVG += '<g transform="scale(0.8)">'
        cLoadSVG += '    <g transform="translate(-50 -50)">'
        cLoadSVG += '    <g transform="translate(2.95261 14.0948)">'
        cLoadSVG += '        <animateTransform attributeName="transform" type="translate" repeatCount="indefinite" dur="1s" values="-20 -20;20 -20;0 20;-20 -20" keyTimes="0;0.33;0.66;1"></animateTransform>'
        cLoadSVG += '        <path fill="#46dff0" d="M44.19 26.158c-4.817 0-9.345 1.876-12.751 5.282c-3.406 3.406-5.282 7.934-5.282 12.751 c0 4.817 1.876 9.345 5.282 12.751c3.406 3.406 7.934 5.282 12.751 5.282s9.345-1.876 12.751-5.282 c3.406-3.406 5.282-7.934 5.282-12.751c0-4.817-1.876-9.345-5.282-12.751C53.536 28.033 49.007 26.158 44.19 26.158z"></path>'
        cLoadSVG += '        <path fill="#1f191b" d="M78.712 72.492L67.593 61.373l-3.475-3.475c1.621-2.352 2.779-4.926 3.475-7.596c1.044-4.008 1.044-8.23 0-12.238 c-1.048-4.022-3.146-7.827-6.297-10.979C56.572 22.362 50.381 20 44.19 20C38 20 31.809 22.362 27.085 27.085 c-9.447 9.447-9.447 24.763 0 34.21C31.809 66.019 38 68.381 44.19 68.381c4.798 0 9.593-1.425 13.708-4.262l9.695 9.695 l4.899 4.899C73.351 79.571 74.476 80 75.602 80s2.251-0.429 3.11-1.288C80.429 76.994 80.429 74.209 78.712 72.492z M56.942 56.942 c-3.406 3.406-7.934 5.282-12.751 5.282s-9.345-1.876-12.751-5.282c-3.406-3.406-5.282-7.934-5.282-12.751 c0-4.817 1.876-9.345 5.282-12.751c3.406-3.406 7.934-5.282 12.751-5.282c4.817 0 9.345 1.876 12.751 5.282 c3.406 3.406 5.282 7.934 5.282 12.751C62.223 49.007 60.347 53.536 56.942 56.942z"></path>'
        cLoadSVG += '    </g>'
        cLoadSVG += '    </g>'
        cLoadSVG += '</g>'
        cLoadSVG += '</g>'
        cLoadSVG += '<!-- [ldio] generated by https://loading.io/ --></svg>'

    Case nType == 8        

 
        // ------------------------------- +
        // SVG MODELO ESTILO SETA CIRCULAR |
        // -------------------------------- +

        cLoadSVG += '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: none; display: block; shape-rendering: auto;" width="110px" height="110px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">'
        cLoadSVG += '<g transform="rotate(230.379 50 50)">'
        cLoadSVG += '<path d="M50 15A35 35 0 1 0 74.74873734152916 25.251262658470843" fill="none" stroke="#83064b" stroke-width="12"></path>'
        cLoadSVG += '<path d="M49 3L49 27L61 15L49 3" fill="#83064b"></path>'
        cLoadSVG += '<animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" dur="1s" values="0 50 50;360 50 50" keyTimes="0;1"></animateTransform>'
        cLoadSVG += '</g>'
        cLoadSVG += '<!-- [ldio] generated by https://loading.io/ --></svg>'

    OTHERWISE

        // ---------------------------+
        // SVG PADRAO PROTHEUS        |
        // ---------------------------+

        cLoadSVG += "<?xml version='1.0' standalone='no'?> <!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.1//EN' "
        cLoadSVG += "'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'>"
        cLoadSVG += "<svg width='250' height='120' version='1.1' xmlns='http://www.w3.org/2000/svg'>"
        cLoadSVG += "<g transform='translate(18,18) rotate(45)' >"
        cLoadSVG += "	<circle fill='none' stroke='#424142' cx='0' cy='0' r='16' stroke-width='3' />"
        cLoadSVG += "  <line x1='-13' y1='-13' x2='13' y2='13' stroke='#ffffff' stroke-width='4'  />"
        cLoadSVG += "	<animateTransform attributeName='transform' type='rotate' values='0; 360'"
        cLoadSVG += " 	 dur='2s' repeatCount='indefinite' rotate='auto'/>"
        cLoadSVG += "</g>"
        cLoadSVG += "<circle fill='#ffffff' cx='18' cy='18' r='11' stroke-width='3'/>"
        cLoadSVG += "<g transform='translate(18,18) rotate(45)' >"
        cLoadSVG += "	<circle fill='none' stroke='#9C9A9C' cx='0' cy='0' r='11' stroke-width='3'/>"
        cLoadSVG += "	<circle fill='#ffffff' cx='2' cy='0' r='11.5' stroke-width='3'/>"
        cLoadSVG += "	<line x1='0' y1='13' x2='2' y2='-12' stroke='#ffffff' stroke-width='5'  />"
        cLoadSVG += "	<line x1='2' y1='14' x2='4' y2='-14' stroke='#ffffff' stroke-width='2'  />"
        cLoadSVG += "	<line x1='4' y1='13' x2='6' y2='-13' stroke='#ffffff' stroke-width='2'  />"
        cLoadSVG += "	<animateTransform attributeName='transform' type='rotate' values='360; 0'"
        cLoadSVG += " 	 dur='1.3s' repeatCount='indefinite' rotate='auto'/>"
        cLoadSVG += "</g>"

        cLoadSVG += "</svg>"
        

EndCase 


Return(cLoadSVG)


// ------------------------------------------ +
// EXEMPLO DE UTILIZAÇÃO DA FUNCAO U_LbMsgRun |
// ------------------------------------------ +
User Function TesteRun()

Local bExec     := { | oSay | Simular( oSay )}
Local cTitle    := "Meu Titulo"
Local cText     := "Calma lá que estamos processando!  "
Local nStyle    := 1
Local nPosLeft  := 0


    U_LbMsgRun( bExec, cTitle, cText, nStyle, nPosLeft, /*GetSvgCustom()*/ )
    U_LbMsgRun( bExec, cTitle, cText, 2, nPosLeft, /*GetSvgCustom()*/ )
    U_LbMsgRun( bExec, cTitle, cText, 3, nPosLeft, /*GetSvgCustom()*/ )
    U_LbMsgRun( bExec, cTitle, cText, 4, nPosLeft, /*GetSvgCustom()*/ )
    U_LbMsgRun( bExec, cTitle, cText, 5, nPosLeft, /*GetSvgCustom()*/ )    
    U_LbMsgRun( bExec, cTitle, cText, 6, nPosLeft, /*GetSvgCustom()*/ )    
    U_LbMsgRun( bExec, cTitle, cText, 7, nPosLeft, /*GetSvgCustom()*/ )    
    U_LbMsgRun( bExec, cTitle, cText, 8, nPosLeft, /*GetSvgCustom()*/ )    
    U_LbMsgRun( bExec, cTitle, cText, 0, nPosLeft, /*GetSvgCustom()*/ )    

Return()


//---------------------------------- +
// Função para simular processamento |
//---------------------------------- +
Static Function Simular( oSay )

Local nX := 0

    Sleep(2000)
    For nX := 1 to 1

        // Atenção: Sempre que for atualizar a mensagem de processamento chamar a funcao ProcessMessages() 
        oSay:cCaption := ('Simulando processamento ' + StrZero(nX, 2)) 
        ProcessMessages()
        Sleep(1000)
    Next nX

Return()

