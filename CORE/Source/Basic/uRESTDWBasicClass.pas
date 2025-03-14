unit uRESTDWBasicClass;

{$I ..\..\Source\Includes\uRESTDWPlataform.inc}

{
  REST Dataware .
  Criado por XyberX (Gilbero Rocha da Silva), o REST Dataware tem como objetivo o uso de REST/JSON
 de maneira simples, em qualquer Compilador Pascal (Delphi, Lazarus e outros...).
  O REST Dataware tamb�m tem por objetivo levar componentes compat�veis entre o Delphi e outros Compiladores
 Pascal e com compatibilidade entre sistemas operacionais.
  Desenvolvido para ser usado de Maneira RAD, o REST Dataware tem como objetivo principal voc� usu�rio que precisa
 de produtividade e flexibilidade para produ��o de Servi�os REST/JSON, simplificando o processo para voc� programador.

 Membros do Grupo :

 XyberX (Gilberto Rocha)    - Admin - Criador e Administrador  do pacote.
 Alexandre Abbade           - Admin - Administrador do desenvolvimento de DEMOS, coordenador do Grupo.
 Anderson Fiori             - Admin - Gerencia de Organiza��o dos Projetos
 Fl�vio Motta               - Member Tester and DEMO Developer.
 Mobius One                 - Devel, Tester and Admin.
 Gustavo                    - Criptografia and Devel.
 Eloy                       - Devel.
 Roniery                    - Devel.
}

interface

Uses
  SysUtils, Classes,
  uRESTDWComponentBase, uRESTDWConsts, uRESTDWDataUtils, uRESTDWComponentEvents,
  uRESTDWEncodeClass, uRESTDWBasicTypes;

Type
 TRESTDWClientRESTBase = Class(TRESTDWComponent) //Novo Componente de Acesso a Requisi��es REST para o Servidores Diversos
 Private
  //Vari�veis, Procedures e Fun��es Privadas
  vRSCharset           : TEncodeSelect;
  vLastErrorCode,
  vRedirectMaximum     : Integer;
  vDefaultCustomHeader : TStrings;
  vOnWorkBegin,
  vOnWork              : TOnWork;
  vOnWorkEnd           : TOnWorkEnd;
  vOnStatus            : TOnStatus;
  vAuthOptionParams    : TRESTDWClientAuthOptionParams;
  vMaxAuthRetries      : Integer;
  vLastErrorMessage,
  vCharset,
  vAUrl,
  vContentEncoding,
  vAccept,
  vAccessControlAllowOrigin,
  vUserAgent,
  vAcceptEncoding,
  vContentType         : String;
  vTransparentProxy    : TProxyConnectionInfo;
  vAllowCookies,
  vHandleRedirects,
  vUseSSL              : Boolean;
  vConnectTimeOut,
  vRequestTimeOut      : Integer;
  vOnBeforeGet         : TPrepareGet;
  vOnBeforePost,
  vOnBeforePut,
  vOnBeforeDelete,
  vOnBeforePatch       : TPrepareEvent;
  vOnAfterRequest      : TAfterRequest;
  vOnHeadersAvailable  : TOnHeadersAvailable;
  Procedure SetAuthOptionParams(Value    : TRESTDWClientAuthOptionParams);
  Procedure SetDefaultCustomHeader(Value : TStrings);
  Function  GetUseSSL                    : Boolean;
  Function  GetAllowCookies              : Boolean;
  Procedure SetAllowCookies   (Value     : Boolean);
  Function  GetHandleRedirects           : Boolean;
  Procedure SetHandleRedirects(Value     : Boolean);
 Public
  Procedure SetHeaders (AHeaders         : TStringList); Virtual;Abstract;
  Procedure SetUseSSL  (Value            : Boolean);     Virtual;
  Procedure SetOnWork          (Value    : TOnWork);     Virtual;
  Procedure SetOnWorkBegin     (Value    : TOnWork);     Virtual;
  Procedure SetOnWorkEnd       (Value    : TOnWorkEnd);  Virtual;
  Procedure SetOnStatus        (Value    : TOnStatus);   Virtual;
  Procedure DestroyClient;                               Virtual;Abstract;
  Constructor Create           (AOwner   : TComponent);  Override;
  Destructor  Destroy;Override;
  Function   Get       (AUrl            : String         = '';
                        CustomHeaders   : TStringList    = Nil;
                        Const AResponse : TStream        = Nil;
                        IgnoreEvents    : Boolean        = False):Integer;Overload;Virtual;
  Function   Get       (AUrl            : String         = '';
                        CustomHeaders   : TStringList    = Nil;
                        IgnoreEvents    : Boolean        = False):String; Overload;Virtual;
  Function   Post      (AUrl             : String         = '';
                        CustomHeaders    : TStringList    = Nil;
                        Const CustomBody : TStream        = Nil;
                        IgnoreEvents     : Boolean        = False;
                        RawHeaders       : Boolean        = False):Integer;Overload;Virtual;
  Function   Post      (AUrl            : String         = '';
                        CustomHeaders   : TStringList    = Nil;
                        CustomBody      : TStringList    = Nil;
                        Const AResponse : TStringStream  = Nil;
                        IgnoreEvents    : Boolean        = False;
                        RawHeaders      : Boolean        = False):Integer;Overload;Virtual;
  Function   Post      (AUrl            : String         = '';
                        CustomHeaders   : TStringList    = Nil;
                        FileName        : String         = '';
                        FileStream      : TStream        = Nil;
                        Const AResponse : TStream        = Nil;
                        IgnoreEvents    : Boolean        = False;
                        RawHeaders      : Boolean        = False):Integer;Overload;Virtual;
  Function   Post      (AUrl            : String;
                        var AResponseText : String;
                        CustomHeaders   : TStringList    = Nil;
                        CustomParams    : TStringList    = Nil;
                        Const CustomBody : TStream        = Nil;
                        Const AResponse : TStream        = Nil;
                        IgnoreEvents    : Boolean        = False;
                        RawHeaders      : Boolean        = False):Integer;Overload;Virtual;
  Function   Post      (AUrl            : String;
                        CustomHeaders   : TStringList    = Nil;
                        CustomParams    : TStringList    = Nil;
                        FileName        : String         = '';
                        FileStream      : TStream        = Nil;
                        Const AResponse : TStream        = Nil;
                        IgnoreEvents    : Boolean        = False;
                        RawHeaders      : Boolean        = False):Integer;Overload;Virtual;
  Function   Put       (AUrl            : String         = '';
                        CustomHeaders   : TStringList    = Nil;
                        Const AResponse : TStream        = Nil;
                        IgnoreEvents    : Boolean        = False):Integer;Overload;Virtual;
  Function   Put       (AUrl            : String         = '';
                        CustomHeaders    : TStringList    = Nil;
                        Const CustomBody : TStream        = Nil;
                        Const AResponse  : TStream        = Nil;
                        IgnoreEvents     : Boolean        = False):Integer;Overload;Virtual;
  Function   Put       (AUrl             : String         = '';
                        CustomHeaders    : TStringList    = Nil;
                        FileName         : String         = '';
                        FileStream       : TStream        = Nil;
                        Const AResponse  : TStream        = Nil;
                        IgnoreEvents     : Boolean        = False):Integer;Overload;Virtual;
  Function   Put       (AUrl            : String         = '';
                        CustomHeaders    : TStringList    = Nil;
                        CustomParams     : TStringList    = Nil;
                        Const CustomBody : TStream        = Nil;
                        Const AResponse  : TStream        = Nil;
                        IgnoreEvents     : Boolean        = False):Integer;Overload;Virtual;
  Function   Put       (AUrl            : String         = '';
                        CustomHeaders    : TStringList    = Nil;
                        CustomParams     : TStringList    = Nil;
                        FileName         : String         = '';
                        FileStream       : TStream        = Nil;
                        Const AResponse  : TStream        = Nil;
                        IgnoreEvents     : Boolean        = False):Integer;Overload;Virtual;
  Function   Patch     (AUrl            : String         = '';
                        CustomHeaders   : TStringList    = Nil;
                        Const AResponse : TStream        = Nil;
                        IgnoreEvents    : Boolean        = False):Integer;Overload;Virtual;
  Function   Patch     (AUrl            : String         = '';
                        CustomHeaders   : TStringList    = Nil;
                        CustomBody      : TStream        = Nil;
                        Const AResponse : TStream        = Nil;
                        IgnoreEvents    : Boolean        = False):Integer;Overload;Virtual;
  Function   Patch     (AUrl            : String         = '';
                        CustomHeaders   : TStringList    = Nil;
                        CustomParams    : TStringList    = Nil;
                        CustomBody      : TStream        = Nil;
                        Const AResponse : TStream        = Nil;
                        IgnoreEvents    : Boolean        = False):Integer;Overload;Virtual;
  Function   Patch     (AUrl            : String         = '';
                        CustomHeaders   : TStringList    = Nil;
                        CustomParams    : TStringList    = Nil;
                        FileName        : String         = '';
                        FileStream      : TStream        = Nil;
                        Const AResponse : TStream        = Nil;
                        IgnoreEvents    : Boolean        = False):Integer;Overload;Virtual;
  Function   Delete    (AUrl            : String         = '';
                        CustomHeaders   : TStringList    = Nil;
                        Const AResponse : TStream        = Nil;
                        IgnoreEvents    : Boolean        = False):Integer;Overload;Virtual;
  Function   Delete    (AUrl              : String;
                        CustomHeaders     : TStringList  = Nil;
                        CustomParams      : TStringList  = Nil;
                        Const AResponse   : TStream      = Nil;
                        IgnoreEvents      : Boolean      = False):Integer;Overload;Virtual;
  Property ActiveRequest            : String                        Read vAUrl                     Write vAUrl;
  Property LastErrorMessage         : String                        Read vLastErrorMessage         Write vLastErrorMessage;
  Property LastErrorCode            : Integer                       Read vLastErrorCode            Write vLastErrorCode;
 Published
  Property UseSSL                   : Boolean                       Read GetUseSSL                 Write SetUseSSL;
  Property UserAgent                : String                        Read vUserAgent                Write vUserAgent;
  Property Accept                   : String                        Read vAccept                   Write vAccept;
  Property Charset                  : String                        Read vCharset                  Write vCharset;
  Property AcceptEncoding           : String                        Read vAcceptEncoding           Write vAcceptEncoding;
  Property ContentEncoding          : String                        Read vContentEncoding          Write vContentEncoding;
  Property MaxAuthRetries           : Integer                       Read vMaxAuthRetries           Write vMaxAuthRetries;
  Property ContentType              : String                        Read vContentType              Write vContentType;
  Property RequestCharset           : TEncodeSelect                 Read vRSCharset                Write vRSCharset;
  Property DefaultCustomHeader      : TStrings                      Read vDefaultCustomHeader      Write SetDefaultCustomHeader;
  Property RequestTimeOut           : Integer                       Read vRequestTimeOut           Write vRequestTimeOut;
  Property ConnectTimeOut           : Integer                       Read vConnectTimeOut           Write vConnectTimeOut;
  Property RedirectMaximum          : Integer                       Read vRedirectMaximum          Write vRedirectMaximum;
  Property AllowCookies             : Boolean                       Read GetAllowCookies           Write SetAllowCookies;
  Property HandleRedirects          : Boolean                       Read GetHandleRedirects        Write SetHandleRedirects;
  Property AuthenticationOptions    : TRESTDWClientAuthOptionParams Read vAuthOptionParams         Write SetAuthOptionParams;
  Property AccessControlAllowOrigin : String                        Read vAccessControlAllowOrigin Write vAccessControlAllowOrigin;
  Property ProxyOptions             : TProxyConnectionInfo          Read vTransparentProxy         Write vTransparentProxy;
  Property OnWork                   : TOnWork                       Read vOnWork                   Write SetOnWork;
  Property OnWorkBegin              : TOnWork                       Read vOnWorkBegin              Write SetOnWorkBegin;
  Property OnWorkEnd                : TOnWorkEnd                    Read vOnWorkEnd                Write SetOnWorkEnd;
  Property OnStatus                 : TOnStatus                     Read vOnStatus                 Write SetOnStatus;
  Property OnBeforeGet              : TPrepareGet                   Read vOnBeforeGet              Write vOnBeforeGet;
  Property OnBeforePost             : TPrepareEvent                 Read vOnBeforePost             Write vOnBeforePost;
  Property OnBeforePut              : TPrepareEvent                 Read vOnBeforePut              Write vOnBeforePut;
  Property OnBeforeDelete           : TPrepareEvent                 Read vOnBeforeDelete           Write vOnBeforeDelete;
  Property OnBeforePatch            : TPrepareEvent                 Read vOnBeforePatch            Write vOnBeforePatch;
  Property OnAfterRequest           : TAfterRequest                 Read vOnAfterRequest           Write vOnAfterRequest;
  Property OnHeadersAvailable       : TOnHeadersAvailable           Read vOnHeadersAvailable       Write vOnHeadersAvailable;
End;

implementation

Procedure TRESTDWClientRESTBase.SetOnWork(Value : TOnWork);
Begin
 {$IFDEF FPC}
  vOnWork            := Value;
 {$ELSE}
  vOnWork            := Value;
 {$ENDIF}
End;

Procedure TRESTDWClientRESTBase.SetOnWorkBegin(Value: TOnWork);
Begin
 {$IFDEF FPC}
  vOnWorkBegin            := Value;
 {$ELSE}
  vOnWorkBegin            := Value;
 {$ENDIF}
End;

procedure TRESTDWClientRESTBase.SetOnWorkEnd(Value: TOnWorkEnd);
begin
 {$IFDEF FPC}
  vOnWorkEnd            := Value;
 {$ELSE}
  vOnWorkEnd            := Value;
 {$ENDIF}
end;

procedure TRESTDWClientRESTBase.SetOnStatus(Value: TOnStatus);
begin
 {$IFDEF FPC}
  vOnStatus            := Value;
 {$ELSE}
  vOnStatus            := Value;
 {$ENDIF}
end;

Procedure TRESTDWClientRESTBase.SetAllowCookies(Value : Boolean);
Begin
 vAllowCookies := Value;
End;

Procedure TRESTDWClientRESTBase.SetAuthOptionParams(Value : TRESTDWClientAuthOptionParams);
Begin
 vAuthOptionParams.Assign(Value);
End;

Procedure TRESTDWClientRESTBase.SetDefaultCustomHeader(Value: TStrings);
Begin
 vDefaultCustomHeader.Assign(value);
End;

Procedure TRESTDWClientRESTBase.SetUseSSL(Value     : Boolean);
Begin
 vUseSSL := Value;
End;

Function TRESTDWClientRESTBase.GetUseSSL : Boolean;
Begin
 Result := vUseSSL;
End;

Procedure TRESTDWClientRESTBase.SetHandleRedirects(Value : Boolean);
Begin
 vHandleRedirects := Value;
End;

Constructor TRESTDWClientRESTBase.Create(AOwner: TComponent);
Begin
 Inherited;
 vContentType                    := 'application/json';
 vContentEncoding                := 'multipart/form-data';
 vAccept                         := 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
 vAcceptEncoding                 := '';
 vCharset                        := 'utf8';
 vMaxAuthRetries                 := 0;
 vUserAgent                      := cUserAgent;
 vAuthOptionParams               := TRESTDWClientAuthOptionParams.Create(Self);
 vTransparentProxy               := TProxyConnectionInfo.Create;
 vAuthOptionParams.AuthorizationOption := rdwAONone;
 vAccessControlAllowOrigin       := '*';
 vAUrl                           := '';
 vRedirectMaximum                := 1;
 vDefaultCustomHeader            := TStringList.Create;
 vLastErrorCode                  := 0;
 vLastErrorMessage               := '';
 {$IFDEF FPC}
  vRSCharset                     := esUtf8;
 {$ELSE}
   {$IF CompilerVersion < 21}
    vRSCharset                   := esAnsi;
   {$ELSE}
    vRSCharset                   := esUtf8;
   {$IFEND}
 {$ENDIF}
 vRequestTimeOut                 := 5000;
 vConnectTimeOut                 := 5000;
End;

Function TRESTDWClientRESTBase.Delete(AUrl            : String;
                                      CustomHeaders   : TStringList;
                                      Const AResponse : TStream;
                                      IgnoreEvents    : Boolean): Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Delete(AUrl            : String;
                                      CustomHeaders,
                                      CustomParams    : TStringList;
                                      Const AResponse : TStream;
                                      IgnoreEvents    : Boolean): Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Destructor TRESTDWClientRESTBase.Destroy;
Begin
 FreeAndNil(vDefaultCustomHeader);
 FreeAndNil(vTransparentProxy);
 If Assigned(vAuthOptionParams) Then
  FreeAndNil(vAuthOptionParams);
 Inherited;
End;

Function TRESTDWClientRESTBase.Get(AUrl            : String;
                                   CustomHeaders   : TStringList;
                                   Const AResponse : TStream;
                                   IgnoreEvents    : Boolean) : Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Get(AUrl          : String;
                                   CustomHeaders : TStringList;
                                   IgnoreEvents  : Boolean): String;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.GetAllowCookies : Boolean;
Begin
 Result := vAllowCookies;
End;

Function TRESTDWClientRESTBase.GetHandleRedirects : Boolean;
Begin
 Result := vHandleRedirects;
End;

Function TRESTDWClientRESTBase.Patch(AUrl            : String;
                                     CustomHeaders,
                                     CustomParams    : TStringList;
                                     FileName        : String;
                                     FileStream      : TStream;
                                     Const AResponse : TStream;
                                     IgnoreEvents    : Boolean) : Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Patch(AUrl            : String;
                                     CustomHeaders   : TStringList;
                                     Const AResponse : TStream;
                                     IgnoreEvents    : Boolean) : Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Patch(AUrl            : String;
                                     CustomHeaders   : TStringList;
                                     CustomBody      : TStream;
                                     Const AResponse : TStream;
                                     IgnoreEvents    : Boolean): Integer;
Begin

End;

Function TRESTDWClientRESTBase.Patch(AUrl            : String;
                                     CustomHeaders,
                                     CustomParams    : TStringList;
                                     CustomBody      : TStream;
                                     Const AResponse : TStream;
                                     IgnoreEvents    : Boolean): Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Post  (AUrl             : String;
                                      CustomHeaders    : TStringList;
                                      Const CustomBody : TStream;
                                      IgnoreEvents,
                                      RawHeaders       : Boolean) : Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Post  (AUrl            : String         = '';
                                      CustomHeaders   : TStringList    = Nil;
                                      CustomBody      : TStringList    = Nil;
                                      Const AResponse : TStringStream  = Nil;
                                      IgnoreEvents    : Boolean        = False;
                                      RawHeaders      : Boolean        = False):Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Post  (AUrl              : String;
                                      Var AResponseText : String;
                                      CustomHeaders     : TStringList    = Nil;
                                      CustomParams      : TStringList    = Nil;
                                      Const CustomBody  : TStream        = Nil;
                                      Const AResponse   : TStream        = Nil;
                                      IgnoreEvents      : Boolean        = False;
                                      RawHeaders        : Boolean        = False):Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Post  (AUrl            : String;
                                      CustomHeaders   : TStringList;
                                      FileName        : String;
                                      FileStream      : TStream;
                                      Const AResponse : TStream;
                                      IgnoreEvents,
                                      RawHeaders      : Boolean) : Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Post  (AUrl            : String;
                                      CustomHeaders,
                                      CustomParams    : TStringList;
                                      FileName        : String;
                                      FileStream      : TStream;
                                      Const AResponse : TStream;
                                      IgnoreEvents,
                                      RawHeaders      : Boolean): Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Put   (AUrl              : String;
                                      CustomHeaders,
                                      CustomParams      : TStringList;
                                      Const CustomBody,
                                      AResponse         : TStream;
                                      IgnoreEvents      : Boolean): Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Put   (AUrl            : String;
                                      CustomHeaders,
                                      CustomParams    : TStringList;
                                      FileName        : String;
                                      FileStream      : TStream;
                                      Const AResponse : TStream;
                                      IgnoreEvents    : Boolean) : Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Put   (AUrl            : String;
                                      CustomHeaders   : TStringList;
                                      FileName        : String;
                                      FileStream      : TStream;
                                      Const AResponse : TStream;
                                      IgnoreEvents    : Boolean): Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Put   (AUrl            : String;
                                      CustomHeaders   : TStringList;
                                      Const AResponse : TStream;
                                      IgnoreEvents    : Boolean): Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

Function TRESTDWClientRESTBase.Put   (AUrl              : String;
                                      CustomHeaders     : TStringList;
                                      Const CustomBody,
                                      AResponse         : TStream;
                                      IgnoreEvents      : Boolean): Integer;
Begin
 Raise Exception.Create(cMethodNotImplemented);
End;

end.
