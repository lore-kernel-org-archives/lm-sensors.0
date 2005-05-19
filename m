From: David.Monniaux@ens.fr (David Monniaux)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: SiS 648, P4S8X: success (not total, but still good)
Message-Id: <Pine.GSO.4.03.10302270143250.11789-100000@basilic.ens.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E5D5A3B.9010701@ens.fr>
In-Reply-To: <3E5D5A3B.9010701@ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 27 Feb 2003, David Monniaux wrote:

> On this ASUS P4S8X motherboard, none of the fan inputs seems to work. 
> It's probably due to the Q-Fan (auto-adjusting fan speed) feature of the 
> motherboard. I don't know how the BIOS reads the fan speed.

Actually the fan input works - I forgot to remove a # before a divisor
entry in /etc/sensors.conf! Oh well...

You need a x8 divisor on the P4S8X.

David Monniaux            http://www.di.ens.fr/~monniaux
Laboratoire d'informatique de l'?cole Normale Sup?rieure,
Paris, France

