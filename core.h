/* Code generated by cmd/cgo; DO NOT EDIT. */

/* package command-line-arguments */


#line 1 "cgo-builtin-export-prolog"

#include <stddef.h> /* for ptrdiff_t below */

#ifndef GO_CGO_EXPORT_PROLOGUE_H
#define GO_CGO_EXPORT_PROLOGUE_H

#ifndef GO_CGO_GOSTRING_TYPEDEF
typedef struct {
    const char *p;
    ptrdiff_t n;
} _GoString_;
#endif

#endif

/* Start of preamble from import "C" comments.  */




/* End of preamble from import "C" comments.  */


/* Start of boilerplate cgo prologue.  */
#line 1 "cgo-gcc-export-header-prolog"

#ifndef GO_CGO_PROLOGUE_H
#define GO_CGO_PROLOGUE_H

typedef signed char GoInt8;
typedef unsigned char GoUint8;
typedef short GoInt16;
typedef unsigned short GoUint16;
typedef int GoInt32;
typedef unsigned int GoUint32;
typedef long long GoInt64;
typedef unsigned long long GoUint64;
typedef GoInt64 GoInt;
typedef GoUint64 GoUint;
typedef __SIZE_TYPE__ GoUintptr;
typedef float GoFloat32;
typedef double GoFloat64;
typedef float _Complex GoComplex64;
typedef double _Complex GoComplex128;

/*
  static assertion to make sure the file is being used on architecture
  at least with matching size of GoInt.
*/
typedef char _check_for_64_bit_pointer_matching_GoInt[sizeof(void *) == 64 / 8 ? 1 : -1];

#ifndef GO_CGO_GOSTRING_TYPEDEF
typedef _GoString_ GoString;
#endif
typedef void *GoMap;
typedef void *GoChan;
typedef struct {
    void *t;
    void *v;
} GoInterface;
typedef struct {
    void *data;
    GoInt len;
    GoInt cap;
} GoSlice;

#endif

/* End of boilerplate cgo prologue.  */

#ifdef __cplusplus
extern "C" {
#endif

extern void Init();

/* Return type for OpenConfFile */
struct OpenConfFile_return {
    int r0; /* clientPort */
    int r1; /* clientHTTPPort */
    int r2; /* clientTransparentPort */
    char *r3; /* clientServer */
    char *r4; /* clientUsername */
    char *r5; /* clientPassword */
    int r6; /* clientProxyAll */
    char *r7; /* DNSType */
    char *r8; /* DNSServer */
    char *r9; /* DNSAddr */
    char *r10; /* logFile */
    char *r11; /* logLevel */
    char *r12; /* ret */
};
extern struct OpenConfFile_return OpenConfFile(char *filePath);
extern char *
SaveConfFile(char *filePath, int clientPort, int clientHTTPPort, int clientTransparentPort, char *clientServer,
             char *clientUsername, char *clientPassword, int clientProxyAll, char *DNSType, char *DNSServer,
             char *DNSAddr, char *logFile, char *logLevel);
extern char *
Validate(int clientPort, int clientHTTPPort, int clientTransparentPort, char *clientServer, char *clientUsername,
         char *clientPassword, int clientProxyAll, char *DNSType, char *DNSServer, char *DNSAddr, char *logFile,
         char *logLevel);
extern char *
Run(int clientPort, int clientHTTPPort, int clientTransparentPort, char *clientServer, char *clientUsername,
    char *clientPassword, int clientProxyAll, char *DNSType, char *DNSServer, char *DNSAddr, char *logFile,
    char *logLevel);
extern void Stop();

#ifdef __cplusplus
}
#endif
