From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Ticket 1834 Update
Message-Id: <41B62E77.80409@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B1D44F.4090303@vfx.to>
In-Reply-To: <41B1D44F.4090303@vfx.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For fan 1,
my version of the datasheet shows 24 MHz for bit7 = 0.
(24 MHz / 1) / 256 = 93.75 kHz

fan 2 matches what you have below.
go figure...

Jean Delvare wrote:
>>But 125 kHz is a bad default (and my math and datasheet show a default
>>of 24 MHz / 256 = 93.75 kHz... Khali where did you get 125 kHz?)
> 
> 
>>From the datasheet !
> 
> Power on default [7:0] = 0000,0001 b
> Bit          Name             Read/Write                           Description
>   7    PWM_CLK_SEL2          Read/Write     PWM 2 Input Clock Select. This bit select Fan 2 input
>                                             clock to pre-scale divider.
>                                             0: 1 MHz
>                                             1: 125 KHz
> 6-0    PRE_SCALE2[6:0]       Read/Write     Fan 2 Input Clock Pre-Scale. The divider of input
>                                             clock is the number defined by pre-scale. Thus, writing
>                                             0 transfers the input clock directly to counter. The
>                                             maximum divider is 128 (7Fh).
>                                             01h : divider is 1
>                                             02h : divider is 2
>                                             03h : divider is 3
> 
> PWM frequency = (Input Clock / Pre-scale) / 256
> 
> 
> Now it seems that I read it wrong, the default would be 1MHz not 125kHz.
> 
> Where do YOU get your 93.75 kHz from? :)
> 
