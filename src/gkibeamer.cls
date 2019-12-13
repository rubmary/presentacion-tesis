%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 
%%% wrapper class for beamer with some layout defaults
%%% and a "4-on-1" option for handouts
%%%
%%% Copyright: Malte Helmert
%%% All rights reserved 
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{gkibeamer}[2006/10/30 v0.1 beamer wrapper class]
\RequirePackage{ifthen}

\newboolean{hand@out}
\newboolean{four@on@one}

\DeclareOption{handout}{
  \setboolean{hand@out}{true}
  \PassOptionsToClass{handout}{beamer}
}
\DeclareOption{4-on-1}{
  \setboolean{four@on@one}{true}
}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{beamer}
}
\ProcessOptions
\LoadClass{beamer}

\iffour@on@one
  \RequirePackage{pgf}
  \RequirePackage{pgfpages}

  \definecolor{pagebordercolor}{rgb}{0.129216,0.188235,0.709804}

  \newcounter{@remainder}%
  \newcommand{\set@remainder}[2]{%
    \setcounter{@remainder}{#1}%
    \loop%
    \ifnum\the@remainder<#2\relax%
    \else%
    \addtocounter{@remainder}{-#2}%
    \repeat%
  }

  \newcounter{pageno@temp}
  \newcommand{\border@ifnecessary}[1]{%
    \setcounter{pageno@temp}{\thepage}%
    \addtocounter{pageno@temp}{2}%
    \set@remainder{\thepageno@temp}{4}%
    \addtocounter{@remainder}{2}%
    \ifnum#1<\the@remainder\relax%
    \color{pagebordercolor}\pgfsetlinewidth{2pt}\pgfstroke%
    \fi%
  }

  \pgfpagesdeclarelayout{my@pagelayout}
  {
    \edef\pgfpageoptionheight{\the\paperheight} 
    \edef\pgfpageoptionwidth{\the\paperwidth}
    \edef\pgfpageoptionborder{0pt}
  }
  {
    \pgfpagesphysicalpageoptions
    {%
      logical pages=4,%
      physical height=\pgfpageoptionheight,%
      physical width=\pgfpageoptionwidth%
    }
    \pgfpageslogicalpageoptions{1}
    {%
      border code=\border@ifnecessary{1},%
      border shrink=\pgfpageoptionborder,%
      resized width=.5\pgfphysicalwidth,%
      resized height=.5\pgfphysicalheight,%
      center=\pgfpoint{.25\pgfphysicalwidth}{.75\pgfphysicalheight}%
    }%
    \pgfpageslogicalpageoptions{2}
    {%
      border code=\border@ifnecessary{2},%
      border shrink=\pgfpageoptionborder,%
      resized width=.5\pgfphysicalwidth,%
      resized height=.5\pgfphysicalheight,%
      center=\pgfpoint{.75\pgfphysicalwidth}{.75\pgfphysicalheight}%
    }%
    \pgfpageslogicalpageoptions{3}
    {%
      border code=\border@ifnecessary{3},%
      border shrink=\pgfpageoptionborder,%
      resized width=.5\pgfphysicalwidth,%
      resized height=.5\pgfphysicalheight,%
      center=\pgfpoint{.25\pgfphysicalwidth}{.25\pgfphysicalheight}%
    }%
    \pgfpageslogicalpageoptions{4}
    {%
      border code=\border@ifnecessary{4},%
      border shrink=\pgfpageoptionborder,%
      resized width=.5\pgfphysicalwidth,%
      resized height=.5\pgfphysicalheight,%
      center=\pgfpoint{.75\pgfphysicalwidth}{.25\pgfphysicalheight}%
    }%
  }

  \pgfpagesuselayout{my@pagelayout}[a4paper,landscape,border shrink=5mm]
\fi

\ifhand@out
  \newcommand{\maketitles}{
    \begin{frame}
      \frametitle{\inserttitle}
      \framesubtitle{{\insertdate} --- {\insertsubtitle}}
      \tableofcontents
    \end{frame}
    \begin{frame}
      \titlepage
    \end{frame}
  }
  \useoutertheme{infolines}
  \setbeamertemplate{navigation symbols}{}
\else
  \newcommand{\maketitles}{\maketitle}
  %\usetheme[right,hideothersubsections]{default}
  %\usetheme[right,hideothersubsections]{PaloAlto}
  %\usecolortheme[rgb={0.0,0.34,0.37}]{structure}
  %\usecolortheme[rgb={0.0,0.34,0.77}]{structure}
  %\usecolortheme{crane}
  %\usecolortheme{wolverine}
  %\useinnertheme[shadow=true]{rounded}
  \useinnertheme{circles}
  %\useoutertheme{shadow}
  \setbeamertemplate{headline}{}
  \setbeamertemplate{footline}{}
  \usefonttheme{professionalfonts}
  \setbeamercovered{transparent}
  \setbeamertemplate{navigation symbols}{}
  \setbeamertemplate{sidebar canvas right}[vertical shading][bottom=black,top=palette primary.bg]
  \setbeamercolor{logo}{bg=palette primary.bg}
\fi

%\setbeamertemplate{frametitle}{
%\begin{centering}
%\insertframetitle
%\par
%\end{centering}
%} 

\institute[Universit\"at Freiburg]{Albert-Ludwigs-Universit\"at Freiburg}
\date{}
