import { useNavigate } from "react-router-dom";

function LoginButton() {
    return (
      <div
        className="bg-[#2260ff] relative rounded-[30px] shrink-0 w-full"
        data-name="LoginButton"
      >
        <div className="flex flex-row items-center justify-center relative size-full">
          <div className="box-border content-stretch flex flex-row gap-2.5 items-center justify-center px-[22px] py-2 relative w-full">
            <div className="capitalize flex flex-col font-['SUIT_Variable:SemiBold',_sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#ffffff] text-[24px] text-center text-nowrap tracking-[2.4px]">
              <p className="adjustLetterSpacing block leading-[normal] whitespace-pre">
                로그인
              </p>
            </div>
          </div>
        </div>
      </div>
    );
  }
  
  function DemoButton() {
    const navigate = useNavigate();
  
    return (
      <div
        className="bg-[#cad6ff] relative rounded-[30px] shrink-0 w-full cursor-pointer"
        data-name="DemoButton"
        onClick={() => navigate("/home")} // 또는 ROUTES.HOME 쓰면 좋아
      >
        <div className="flex flex-row items-center justify-center relative size-full">
          <div className="box-border content-stretch flex flex-row gap-2.5 items-center justify-center px-[22px] py-2 relative w-full">
            <div className="capitalize flex flex-col font-['SUIT_Variable:SemiBold',_sans-serif] justify-center leading-[0] not-italic relative shrink-0 text-[#2260ff] text-[24px] text-center text-nowrap tracking-[-0.24px]">
              <p className="adjustLetterSpacing block leading-[normal] whitespace-pre">
                데모버전
              </p>
            </div>
          </div>
        </div>
      </div>
    );
  }
  
  function ButtonGroup() {
    return (
      <div
        className="absolute left-[21.389%] right-[15%] translate-y-[-50%]"
        data-name="ButtonGroup"
        style={{ top: "calc(50% + 276px)" }}
      >
        <div className="relative size-full">
          <div className="box-border content-stretch flex flex-col gap-2.5 items-start justify-start p-[12px] relative w-full">
            <LoginButton />
            <DemoButton />
          </div>
        </div>
      </div>
    );
  }
  
  function Title() {
    return (
      <div className="relative shrink-0 w-full" data-name="Title">
        <div className="box-border capitalize content-stretch flex flex-col items-center justify-start leading-[0] p-0 relative text-center w-full">
          <div className="flex flex-col font-['League_Spartan:SemiBold',_sans-serif] font-semibold justify-center relative shrink-0 text-[#2260ff] text-[16px] w-full">
            <p className="block leading-[normal]">WALKer HOLIC</p>
          </div>
          <div className="[text-shadow:rgba(21,33,167,0.25)_0px_4px_4px] flex flex-col font-['Lilita_One:Regular',_sans-serif] justify-center not-italic relative shrink-0 text-[#4378ff] text-[55px] w-full">
            <p className="block leading-[normal]">bODYFENCE</p>
          </div>
        </div>
      </div>
    );
  }
  
  function TitleGroup() {
    return (
      <div
        className="absolute bottom-1/2 left-[10.278%] right-[10.278%] top-[36%]"
        data-name="TitleGroup"
      >
        <div className="box-border content-stretch flex flex-col items-center justify-start p-0 relative size-full">
          <Title />
          <div className="capitalize flex flex-col font-['League_Spartan:Thin',_sans-serif] font-thin h-[34px] justify-center leading-[0] relative shrink-0 text-[#4378ff] text-[25px] text-center w-full">
            <p className="block leading-[normal]">Walk Safe, Live Smart</p>
          </div>
        </div>
      </div>
    );
  }
  
export default function LoginScreen() {
  return (
    <div
      className="w-[360px] h-[800px] bg-[#ECF1FF] rounded-[30px] relative overflow-hidden"
    >
      <TitleGroup />
      <ButtonGroup />
    </div>
  );
}