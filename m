From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 24 Oct 2005 13:39:03 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <435CC7B9.50007@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Goodenough wrote:
> Rudolf,
> 
> I am not quite sure why I am included in the CC list for this note.  I do not 
> have one of these chips on my system as far as I know, the only only
> ATI chip I have is a Radeon video chip.
> 

> I have a laptop (a Samsumg P28) which has lots of ATI chips in it.  One of 
> them (according to lspci) is an SmBus controller, and it has a PCI id of
> 1002:4353.  Looking at the lmsensors web site there are no bus drivers
> for any ATI chips.  This seems to be one of the functions in the Ati 
> 9000 IGP chip, which is also the video driver.  It is marked as being
> the 9100 IGP chip in the linux PCI repository, but I guess they use the
> same silicon in both chips.

You wrote this correct :) ?

The PCI ID matches so my driver will work for you too.

Regards
Rudolf
