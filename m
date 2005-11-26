From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Sat, 26 Nov 2005 13:31:03 +0000
Subject: [lm-sensors] Analogue Devices ADT7476ARQZ chip status
Message-Id: <20051126123044.GA9695@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4387E587.20302@reub.net>
In-Reply-To: <4387E587.20302@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 26 Nov 2005, Jean Delvare wrote:
> My first impression is that the ADT7476 is partly compatible with the
> ADT7467/ADT7468, which is itself partly compatible with the ADT7463,
> which is an improved version of the ADM1027, which is itself mostly
> compatible with the National Semiconductor LM85. We have a driver
> (lm85) which covers the LM85, ADM1027 and ADT7463. If we want to
> support the ADT7467/ADT7468 and ADT7476, I think we should start a new
> driver. The lm85 driver already supports many chips, let's not add to
> the mess.

Well, that really depends on how the newer chips differ.  If they have
*extra* functionality only (as opposed to *different* functionality) over
whatever is already there for the amd1027 and emc6d102, it could be actually
better to support them on the lm85 driver.  Less duplicate code to keep
track of.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
