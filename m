From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: =?iso-8859-1?Q?Abit_=B5Guru_-_AN7?=
Message-Id: <Pine.LNX.4.58.0404271250140.9179@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <01e701c42c0c$88d5a8f0$796ffd3e@pc1>
In-Reply-To: <01e701c42c0c$88d5a8f0$796ffd3e@pc1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hello,

I found that Abit HW monitor uses  AC2003DLL.dll

Mainly the

     DLL Name: AC2003DLL.dll
        vma:  Hint/Ord Member-Name Bound-To
        5e55a       2  GetDllVersion
        5e56a      18  SetAIP
        5e574       1  GetAIP

Its some kind of command packets for the windobond
device which is a ISA device on 0xE0 (command) and 0xE4 data.

Do yuou know some windows guru that would write a DLL wrapper
for this two functions so is it possible to see what data
are transfred there ?

(this are only functions that comunictate with HW)

I'm speaking for myself not for Lm_sensors project, because I'm
not the developer but I'm on the list.

You can find me on IRC's lm sensors channel

Regards

Rudolf alias Ruik
