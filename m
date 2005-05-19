From: fabrice@yako.via.ecp.fr (Fabrice Ollivier)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: stdarg.h inclusion problem (ticket #1343)
Message-Id: <1058822299.7660.2.camel@kalaha>
List-Id: <lm-sensors.vger.kernel.org>
References: <1058736432.30749.4.camel@kalaha>
In-Reply-To: <1058736432.30749.4.camel@kalaha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Do you have sed installed on your system? Which  version is it?
cif@kalaha ~% sed -V
GNU sed version 4.0.7

> What does the following command return is run from a shell?
> LC_ALL=C gcc -print-search-dirs | sed -ne 's/install: \(.*\)/-I
> \1include/gp'
cif@kalaha ~% LC_ALL=C gcc -print-search-dirs | sed -ne 's/install:
\(.*\)/-I\1include/gp'
-I/usr/lib/gcc-lib/i386-linux/3.3.1/include

My shell is zsh, but I tried with bash, and no changes :)

-- 
Fabrice
