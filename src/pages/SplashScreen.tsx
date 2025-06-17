import React from 'react';

function Title() {
  return (
    <div className="relative shrink-0 w-full">
      <div className="box-border capitalize content-stretch flex flex-col gap-[11px] items-center justify-start leading-[0] p-0 relative text-[#ffffff] w-full">
        <div className="[text-shadow:rgba(21,33,167,0.25)_0px_4px_4px] flex flex-col font-['Lilita_One:Regular',_sans-serif] h-[55px] justify-center not-italic relative shrink-0 text-[55px] text-left w-full">
          <p className="block leading-[normal]">BODYFENCE</p>
        </div>
        <div className="flex flex-col font-['League_Spartan:Thin',_sans-serif] font-thin h-[34px] justify-center relative shrink-0 text-[25px] text-center w-[215px]">
          <p className="block leading-[normal]">Walk Safe, Live Smart</p>
        </div>
      </div>
    </div>
  );
}

function SplashScreenContent() {
  return (
    <div
      className="absolute bg-[#2260ff] left-0 rounded-[30px] top-0 w-[360px]"
      data-name="splash Screen"
    >
      <div className="flex flex-col items-center overflow-clip relative size-full">
        <div className="box-border content-stretch flex flex-col gap-64 items-center justify-start pb-[102px] pt-[334px] px-[37px] relative w-[360px]">
          <Title />
          <div className="capitalize flex flex-col font-['League_Spartan:SemiBold',_sans-serif] font-semibold h-2 justify-center leading-[0] relative shrink-0 text-[#ffffff] text-[15px] text-center w-[142px]">
            <p className="block leading-[normal]">WALKer HOLIC</p>
          </div>
        </div>
      </div>
    </div>
  );
}

export default function SplashScreen() {
  return (
    <div
      className="bg-[#ffffff] overflow-clip relative rounded-[30px] size-full"
      data-name="splash Screen"
    >
      <SplashScreenContent />
    </div>
  );
}