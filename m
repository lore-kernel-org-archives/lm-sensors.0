From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 22 Mar 2007 18:16:03 +0000
Subject: [lm-sensors] #2195: Fails to detect ITE family chip with ID
Message-Id: <191fb4ca0703221116r757c626qb89a4b85eeae1011@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
In-Reply-To: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> There are no standard registers and no standard values to identify I2C
> manufacturers and devices. So adding a few tests where possible cannot
> hurt and is considered a good practice. So unless you have a reason to
> believe that these tests could fail for an otherwise valid chip, I'd
> leave them in. Especially the test of register 0x40 is valuable - the
> test of register 0x42 certainly less.
>
> We don't need to do this for Super-I/O or PCI devices because they have
> standard identification registers.
>
> Can you please provide a patch fixing sensors-detect for the DME1737?

Do you mean just fixing the 0x55?

...juerg


> Thanks,
> --
> Jean Delvare
>

