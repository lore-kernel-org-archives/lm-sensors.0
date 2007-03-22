From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 22 Mar 2007 16:24:14 +0000
Subject: [lm-sensors] #2195: Fails to detect ITE family chip with ID
Message-Id: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes, the chip is a DME1737.
0x3e: 0x5c = SMSC
0x3f: 0x8a = DME1737


Jean: I tried to add the comment to the ticket but get a
'TICKET_APPEND privileges are required to perform this operation'
error. I logged in as user 'ticket'.

...juerg


On 3/21/07, lm-sensors <lm-sensors-notify at lm-sensors.org> wrote:
> #2195: Fails to detect ITE family chip with ID 0x7803
> ---------------------------+------------------------------------------------
>   Reporter:  cc at cs.aau.dk  |       Owner:  khali
>       Type:  enhancement   |      Status:  assigned
>   Priority:  minor         |   Milestone:
>  Component:  hardware      |     Version:  SVN
> Resolution:                |    Keywords:
> ---------------------------+------------------------------------------------
> Changes (by khali):
>
>  * cc: juergh at gmail.com (added)
>
> Comment:
>
>  Juerg, please check this sensors-detect output. The Super-I/O detection
>  finds a DME1737 chip, but the Intel 82801 SMBus probing fails to identify
>  the device at 0x2e as a DME1737.
>
>  Reporter, can you please provide the output of:
>  {{{
>  i2cdump 0 0x2e
>  }}}
>
> --
> Ticket URL: <http://lm-sensors.org/ticket/2195#comment:2>
> lm-sensors <http://lm-sensors.org/>
> Linux hardware monitoring

