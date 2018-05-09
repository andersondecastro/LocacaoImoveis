pragma solidity ^0.4.19;

contract AlugaImovel {
    
    address public Owner;
    uint contadorImoveis;
    uint contadorImoveisLocados;
    
    struct Imovel {
        uint idImovel;
        string enderecoImovel;
        uint valorImovel;
        address proprietario;
        address inquilino;
        bool alugado;
    }
    
    mapping ( uint => Imovel ) imoveis;
    
    function AlugaImovel() {
        Owner = msg.sender;
        contadorImoveis = 0;
        contadorImoveisLocados = 0;
    }
    
    // publicação do imóvel pelo proprietário
    function InscreverImovel( string _endereco, uint _valor ) public {
        var imovel = imoveis[contadorImoveis++];
        imovel.idImovel = contadorImoveis;
        imovel.enderecoImovel = _endereco;
        imovel.valorImovel = _valor;
        imovel.proprietario = msg.sender;
        imovel.inquilino = 0x0;
        imovel.alugado = false;
    }
    
    // aluguel do imóvel pelo inquilino
    function AlugarImovel( uint _idImovel ) public {
        var imovel = imoveis[_idImovel];
        
        require( !imovel.alugado );
        
        imovel.alugado = true;
        imovel.inquilino = msg.sender;
        
        contadorImoveisLocados += 1;
    }
    
    // devolução do imóvel pelo inquilino
    function DevolverImovel( uint _idImovel ) public {
        var imovel = imoveis[_idImovel];
        
        require( imovel.alugado );
        require( imovel.inquilino == msg.sender );
        
        imovel.alugado = false;
        imovel.inquilino = 0x0;
        
        contadorImoveisLocados -= 1;
    }
    
    // mostrar a quantidade total de imoveis, e a quantidade locada
    function Analytics () public returns (uint, uint) {
        return ( contadorImoveis, contadorImoveisLocados ) ;
    }
    
}
