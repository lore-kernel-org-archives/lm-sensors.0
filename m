From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 May 2009 07:07:37 +0000
Subject: Re: [lm-sensors] Support for  nuvoton(Winbond) W83627DHG-P ?
Message-Id: <20090519090737.2b5168ce@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1242369988.21111.53.camel@localhost.localdomain>
In-Reply-To: <1242369988.21111.53.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 18 May 2009 23:49:48 +0530, madhu wrote:
> It was showing as 'W83627DHG-P' on the chip, and also confirmed here,
> http://download.intel.com/support/motherboards/desktop/dg41ty/sb/e5279701_en.pdf (page 17).
>
> Tried with the latest 'sensors-detect' and got the following (attached
> the full result),
> 
> ----------------
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.           
> Do you want to scan for Super I/O sensors? (YES/no):              
> Probing for Super-I/O at 0x2e/0x2f                                
> Trying family `National Semiconductor'...                   No    
> Trying family `SMSC'...                                     No    
> Trying family `VIA/Winbond/Fintek'...                       Yes   
> Found unknown chip with ID 0xb073                                 
> Probing for Super-I/O at 0x4e/0x4f                                
> Trying family `National Semiconductor'...                   No    
> Trying family `SMSC'...                                     No    
> Trying family `VIA/Winbond/Fintek'...                       No    
> Trying family `ITE'...                                      No    
> ------------------

Hmm, then that's the same as:
http://bugzilla.kernel.org/show_bug.cgi?id338

Feel free to add yourself to the Cc list of that bug.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
