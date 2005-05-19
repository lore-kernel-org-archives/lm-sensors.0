From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: Error in SMBUs protocol document
Message-Id: <3EC98EEE.6080500@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <HIEHIBLPFMGOIENAGCDKKEJDCCAA.j.snyers@cherokee.be>
In-Reply-To: <HIEHIBLPFMGOIENAGCDKKEJDCCAA.j.snyers@cherokee.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you are correct.
thank you very much.
fixed in CVS.

Jehan Snyers d'Attenhoven wrote:
>    -->
> 
> Greetings,
> 
>  
> 
> I spotted an important (typo) error in the SMBus protocol document 
> located at:
> 
> http://www2.lm-sensors.nu/~lm78/cvs/i2c/doc/smbus-protocol
> 
>  
> 
> In the SMBus block process call section:
> 
>  
> 
> SMBus Block Process Call
> 
> ============
> 
>  
> 
> SMBus Block Process Call was introduced in Revision 2.0 of the specification.
> 
>  
> 
> This command selects a device register (through the Comm byte), sends
> 
> 1 to 31 bytes of data to it, and reads 1 to 31 bytes of data in return.
> 
>  
> 
> S Addr Wr [A] Comm [A] Count [A] Data [A] ...
> 
>                              S Addr Rd [A] [Count] A [Data] ... A P
> 
>  
> 
>  
> 
> It should be a NACK ending the communication, NOT an ack. I checked with 
> the SMBus specs v2.0, p33 fig 5.21.
> 
> S Addr Wr [A] Comm [A] Count [A] Data [A] ..
> 
>                              S Addr Rd [A] [Count] A [Data] ... *NA* P
> 
>  
> 
> This error can lead some to error, like it did for me ?
> 
> Thank you and best regards.
> 
> --
> 
> *Jehan Snyers d'Attenhoven***
> 
> Project Leader
> 
> /Cherokee Europe///
> 
> http://www.cherokee.be/
> 
> Phone: +32.10.438.394
> 
> Mobile: +32.478.457.490
> 
>  
> 
> *** This message is printed on 100% recyclable electrons. ***
> 
>  
> 
