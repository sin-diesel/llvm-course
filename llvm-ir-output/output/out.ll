; ModuleID = 'top'
source_filename = "top"

@SURF_CUR = common global i8* null, align 8
@SURF_NEXT = common global i8* null, align 8

declare available_externally i8 @getZeroOrOne()

declare available_externally void @init(i64 %0, i64 %1)

declare available_externally i8 @finished()

define internal void @fillRand() {
entry:
  br label %loop

return:                                           ; preds = %loop
  ret void

loop:                                             ; preds = %loop, %entry
  %idx = phi i64 [ 0, %entry ], [ %inc, %loop ]
  %val = call i8 @getZeroOrOne()
  %surf = load i8*, i8** @SURF_CUR, align 8
  %ePtr = getelementptr i8, i8* %surf, i64 %idx
  store i8 %val, i8* %ePtr, align 1
  %inc = add nuw nsw i64 %idx, 1
  %cmp = icmp eq i64 %inc, 230400
  br i1 %cmp, label %return, label %loop
}

define internal i8 @calcState(i64 %0, i64 %1) {
  %3 = load i8*, i8** @SURF_CUR, align 8
  %4 = add i64 %0, -1
  %5 = mul i64 %1, 640
  %6 = add i64 %5, -640
  %7 = add i64 %6, %4
  %8 = getelementptr i8, i8* %3, i64 %7
  %9 = load i8, i8* %8, align 1
  %10 = icmp ne i8 %9, 0
  %11 = zext i1 %10 to i64
  %12 = add i64 %5, %4
  %13 = getelementptr i8, i8* %3, i64 %12
  %14 = load i8, i8* %13, align 1
  %15 = icmp ne i8 %14, 0
  %16 = zext i1 %15 to i64
  %17 = add nuw nsw i64 %16, %11
  %18 = add i64 %5, 640
  %19 = add i64 %18, %4
  %20 = getelementptr i8, i8* %3, i64 %19
  %21 = load i8, i8* %20, align 1
  %22 = icmp ne i8 %21, 0
  %23 = zext i1 %22 to i64
  %24 = add nuw nsw i64 %17, %23
  %25 = add i64 %6, %0
  %26 = getelementptr i8, i8* %3, i64 %25
  %27 = load i8, i8* %26, align 1
  %28 = icmp ne i8 %27, 0
  %29 = zext i1 %28 to i64
  %30 = add nuw nsw i64 %24, %29
  %31 = add i64 %18, %0
  %32 = getelementptr i8, i8* %3, i64 %31
  %33 = load i8, i8* %32, align 1
  %34 = icmp ne i8 %33, 0
  %35 = zext i1 %34 to i64
  %36 = add nuw nsw i64 %30, %35
  %37 = add i64 %0, 1
  %38 = add i64 %6, %37
  %39 = getelementptr i8, i8* %3, i64 %38
  %40 = load i8, i8* %39, align 1
  %41 = icmp ne i8 %40, 0
  %42 = zext i1 %41 to i64
  %43 = add nuw nsw i64 %36, %42
  %44 = add i64 %5, %37
  %45 = getelementptr i8, i8* %3, i64 %44
  %46 = load i8, i8* %45, align 1
  %47 = icmp ne i8 %46, 0
  %48 = zext i1 %47 to i64
  %49 = add nuw nsw i64 %43, %48
  %50 = add i64 %18, %37
  %51 = getelementptr i8, i8* %3, i64 %50
  %52 = load i8, i8* %51, align 1
  %53 = icmp ne i8 %52, 0
  %54 = zext i1 %53 to i64
  %55 = add nuw nsw i64 %49, %54
  ret i64 %55
}

define internal void @calcSurf() {
entry:
  br label %loop.cond.width

loop.cond.height:                                 ; preds = %loop.cond.width
  %line = phi i64 [ 0, %entry ], [ %0, %loop.cond.width ]
  %offset = mul nuw nsw i64 %line, 640
  br label %loop.body

return:                                           ; preds = %loop.cond.width
  ret void

loop.cond.width:                                  ; preds = %loop.body, %entry
  %0 = add nuw nsw i64 %line, 1
  %1 = icmp eq i64 %0, 360
  br i1 %1, label %return, label %loop.cond.height

loop.body:                                        ; preds = %loop.body, %loop.cond.height
  %col = phi i64 [ 0, %loop.cond.height ], [ %2, %loop.body ]
  %idx = add nuw nsw i64 %col, %offset
  %surf = load i8*, i8** @SURF_NEXT, align 8
  %ptr = getelementptr i8, i8* %surf, i64 %idx
  %val = call i8 @calcState(i64 %col, i64 %line)
  store i8 %val, i8* %ptr, align 1
  %2 = add i64 %col, 1
  %3 = icmp eq i64 %2, 640
  br i1 %3, label %loop.cond.width, label %loop.body
}

define i32 @main() {
entry:
  %0 = alloca [230400 x i8], align 1
  %1 = alloca [230400 x i8], align 1
  %2 = getelementptr [230400 x i8], [230400 x i8]* %0, i64 0, i64 0
  store i8* %2, i8** @SURF_CUR, align 8
  call void @fillRand()
  %3 = getelementptr [230400 x i8], [230400 x i8]* %1, i64 0, i64 0
  store i8* %3, i8** @SURF_NEXT, align 8
  call void @init(i64 360, i64 640)
  br label %loop.cond

loop.cond:                                        ; preds = %loop.body, %entry
  %4 = call i8 @finished()
  %5 = icmp eq i8 %4, 0
  br i1 %5, label %loop.body, label %return

loop.body:                                        ; preds = %loop.cond
  call void @calcSurf()
  %6 = call i8 @finished()
  %7 = call i8 @finished()
  br label %loop.cond

return:                                           ; preds = %loop.cond
  ret i32 0
}
