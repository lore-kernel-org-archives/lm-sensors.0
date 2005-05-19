From: aj@ectologic.com (Aj Lavin)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: bmc and fan speed control
Message-Id: <42800C63.8010200@ectologic.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <427FF313.7070202@mds.gotdns.com>
In-Reply-To: <427FF313.7070202@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yani Ioannou wrote:

>On 5/9/05, Mark Studebaker <mds@mds.gotdns.com> wrote:
>  
>
>>2.4 bmcsensors doesn't have write support at all.
>>In fact I didn't realize that 2.6 _did_ have write support.
>>Nice Yani!
>>That is obviously a requirement for setting anything.
>>    
>>
>
>Well I added it for setting max/min/hysteresis limits when porting the
>driver but I couldn't actually test it (my bmc doesn't offer any write
>support) .. so..err I'm surprised if it works :-). I haven't heard
>about it one way or the other from anyone yet.
>
>  
>
>>I've never seen  an IPMI SDR that looked  like PWM control or fan divisor.
>>IPMI systems tend to want to control their  own fan speeds, in my experience, so taking manual control
>>of PWM doesn't really fit  the IPMI paradigm too well.
>>    
>>
>
>That's my (limited) experience too, Aj what specific bmc/motherboard
>are you using? I'd be interested to take a look at any documentation.
>  
>

Intel SHG2 motherboard which I believe uses a Sahalee BMC. It also 
employs an ADM1021 which I think does the fan control. I really just 
want a way to adjust the fan control parameters, or disable fan control 
altogether so that the fans run at full speed. After a recent BIOS 
upgrade the fans have been stuck at 2/3 speed regardless of temperature. 
Unfortunately this machine has already been deployed, so if I need 
console access to adjust the fan speed then it's not going to happen.

The "Technical Product Specification" for the SHG2 is here:
http://support.intel.com/support/motherboards/server/shg2/sb/cs-006520.htm

[ ...]

Thanks!
Aj

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 2773 bytes
Desc: S/MIME Cryptographic Signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050509/867d47d0/smime.bin
