; ModuleID = 'logic.c'
source_filename = "logic.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.rgb_t = type { i32, i32, i32 }

@.str = private unnamed_addr constant [18 x i8] c"cell x, y: %d %d\0A\00", align 1
@__const.count_living_neighbours.green = private unnamed_addr constant %struct.rgb_t { i32 0, i32 255, i32 0 }, align 4
@board_data = external dso_local global [1440000 x i32], align 16
@__const.game_update.green = private unnamed_addr constant %struct.rgb_t { i32 0, i32 255, i32 0 }, align 4
@.str.1 = private unnamed_addr constant [22 x i8] c"num_of_neighbours:%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @display() #0 {
  call void @game_update()
  call void (...) @board_flush()
  %1 = call i32 @sleep(i32 1)
  ret void
}

declare dso_local void @board_flush(...) #1

declare dso_local i32 @sleep(i32) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @init_game() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca %struct.rgb_t, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = call i64 @time(i64* null) #5
  %7 = trunc i64 %6 to i32
  call void @srand(i32 %7) #5
  store i32 0, i32* %1, align 4
  br label %8

8:                                                ; preds = %30, %0
  %9 = load i32, i32* %1, align 4
  %10 = icmp slt i32 %9, 12000
  br i1 %10, label %11, label %33

11:                                               ; preds = %8
  %12 = call i32 @rand() #5
  %13 = srem i32 %12, 800
  store i32 %13, i32* %2, align 4
  %14 = call i32 @rand() #5
  %15 = srem i32 %14, 600
  store i32 %15, i32* %3, align 4
  %16 = load i32, i32* %2, align 4
  %17 = load i32, i32* %3, align 4
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i64 0, i64 0), i32 %16, i32 %17)
  %19 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %4, i32 0, i32 0
  store i32 0, i32* %19, align 4
  %20 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %4, i32 0, i32 1
  store i32 255, i32* %20, align 4
  %21 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %4, i32 0, i32 2
  store i32 0, i32* %21, align 4
  %22 = load i32, i32* %2, align 4
  %23 = load i32, i32* %3, align 4
  %24 = bitcast { i64, i32 }* %5 to i8*
  %25 = bitcast %struct.rgb_t* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %24, i8* align 4 %25, i64 12, i1 false)
  %26 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 0
  %27 = load i64, i64* %26, align 4
  %28 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %5, i32 0, i32 1
  %29 = load i32, i32* %28, align 4
  call void @board_put_pixel(i32 %22, i32 %23, i64 %27, i32 %29)
  br label %30

30:                                               ; preds = %11
  %31 = load i32, i32* %1, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, i32* %1, align 4
  br label %8

33:                                               ; preds = %8
  ret void
}

; Function Attrs: nounwind
declare dso_local void @srand(i32) #2

; Function Attrs: nounwind
declare dso_local i64 @time(i64*) #2

; Function Attrs: nounwind
declare dso_local i32 @rand() #2

declare dso_local i32 @printf(i8*, ...) #1

declare dso_local void @board_put_pixel(i32, i32, i64, i32) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @count_living_neighbours(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, i32 %5, i32 %6, i32 %7) #0 {
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca %struct.rgb_t, align 4
  %19 = alloca %struct.rgb_t, align 4
  %20 = alloca %struct.rgb_t, align 4
  %21 = alloca %struct.rgb_t, align 4
  %22 = alloca %struct.rgb_t, align 4
  %23 = alloca %struct.rgb_t, align 4
  %24 = alloca %struct.rgb_t, align 4
  %25 = alloca %struct.rgb_t, align 4
  %26 = alloca %struct.rgb_t, align 4
  %27 = alloca %struct.rgb_t, align 4
  %28 = alloca { i64, i32 }, align 4
  %29 = alloca { i64, i32 }, align 4
  %30 = alloca { i64, i32 }, align 4
  %31 = alloca { i64, i32 }, align 4
  %32 = alloca { i64, i32 }, align 4
  %33 = alloca { i64, i32 }, align 4
  %34 = alloca { i64, i32 }, align 4
  %35 = alloca { i64, i32 }, align 4
  %36 = alloca { i64, i32 }, align 4
  %37 = alloca { i64, i32 }, align 4
  %38 = alloca { i64, i32 }, align 4
  %39 = alloca { i64, i32 }, align 4
  %40 = alloca { i64, i32 }, align 4
  %41 = alloca { i64, i32 }, align 4
  %42 = alloca { i64, i32 }, align 4
  %43 = alloca { i64, i32 }, align 4
  store i32 %0, i32* %9, align 4
  store i32 %1, i32* %10, align 4
  store i32 %2, i32* %11, align 4
  store i32 %3, i32* %12, align 4
  store i32 %4, i32* %13, align 4
  store i32 %5, i32* %14, align 4
  store i32 %6, i32* %15, align 4
  store i32 %7, i32* %16, align 4
  store i32 0, i32* %17, align 4
  %44 = bitcast %struct.rgb_t* %18 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 4 %44, i8 0, i64 12, i1 false)
  %45 = bitcast %struct.rgb_t* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %45, i8* align 4 bitcast (%struct.rgb_t* @__const.count_living_neighbours.green to i8*), i64 12, i1 false)
  %46 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %20, i32 0, i32 0
  %47 = load i32, i32* %9, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %48
  %50 = load i32, i32* %49, align 4
  store i32 %50, i32* %46, align 4
  %51 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %20, i32 0, i32 1
  %52 = load i32, i32* %9, align 4
  %53 = add nsw i32 %52, 1
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %54
  %56 = load i32, i32* %55, align 4
  store i32 %56, i32* %51, align 4
  %57 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %20, i32 0, i32 2
  %58 = load i32, i32* %9, align 4
  %59 = add nsw i32 %58, 2
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %60
  %62 = load i32, i32* %61, align 4
  store i32 %62, i32* %57, align 4
  %63 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %21, i32 0, i32 0
  %64 = load i32, i32* %10, align 4
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %65
  %67 = load i32, i32* %66, align 4
  store i32 %67, i32* %63, align 4
  %68 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %21, i32 0, i32 1
  %69 = load i32, i32* %10, align 4
  %70 = add nsw i32 %69, 1
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %71
  %73 = load i32, i32* %72, align 4
  store i32 %73, i32* %68, align 4
  %74 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %21, i32 0, i32 2
  %75 = load i32, i32* %10, align 4
  %76 = add nsw i32 %75, 2
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %77
  %79 = load i32, i32* %78, align 4
  store i32 %79, i32* %74, align 4
  %80 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %22, i32 0, i32 0
  %81 = load i32, i32* %11, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %82
  %84 = load i32, i32* %83, align 4
  store i32 %84, i32* %80, align 4
  %85 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %22, i32 0, i32 1
  %86 = load i32, i32* %11, align 4
  %87 = add nsw i32 %86, 1
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %88
  %90 = load i32, i32* %89, align 4
  store i32 %90, i32* %85, align 4
  %91 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %22, i32 0, i32 2
  %92 = load i32, i32* %11, align 4
  %93 = add nsw i32 %92, 2
  %94 = sext i32 %93 to i64
  %95 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %94
  %96 = load i32, i32* %95, align 4
  store i32 %96, i32* %91, align 4
  %97 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %23, i32 0, i32 0
  %98 = load i32, i32* %12, align 4
  %99 = sext i32 %98 to i64
  %100 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %99
  %101 = load i32, i32* %100, align 4
  store i32 %101, i32* %97, align 4
  %102 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %23, i32 0, i32 1
  %103 = load i32, i32* %12, align 4
  %104 = add nsw i32 %103, 1
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %105
  %107 = load i32, i32* %106, align 4
  store i32 %107, i32* %102, align 4
  %108 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %23, i32 0, i32 2
  %109 = load i32, i32* %12, align 4
  %110 = add nsw i32 %109, 2
  %111 = sext i32 %110 to i64
  %112 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %111
  %113 = load i32, i32* %112, align 4
  store i32 %113, i32* %108, align 4
  %114 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %24, i32 0, i32 0
  %115 = load i32, i32* %13, align 4
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %116
  %118 = load i32, i32* %117, align 4
  store i32 %118, i32* %114, align 4
  %119 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %24, i32 0, i32 1
  %120 = load i32, i32* %13, align 4
  %121 = add nsw i32 %120, 1
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %122
  %124 = load i32, i32* %123, align 4
  store i32 %124, i32* %119, align 4
  %125 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %24, i32 0, i32 2
  %126 = load i32, i32* %13, align 4
  %127 = add nsw i32 %126, 2
  %128 = sext i32 %127 to i64
  %129 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %128
  %130 = load i32, i32* %129, align 4
  store i32 %130, i32* %125, align 4
  %131 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %25, i32 0, i32 0
  %132 = load i32, i32* %14, align 4
  %133 = sext i32 %132 to i64
  %134 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %133
  %135 = load i32, i32* %134, align 4
  store i32 %135, i32* %131, align 4
  %136 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %25, i32 0, i32 1
  %137 = load i32, i32* %14, align 4
  %138 = add nsw i32 %137, 1
  %139 = sext i32 %138 to i64
  %140 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %139
  %141 = load i32, i32* %140, align 4
  store i32 %141, i32* %136, align 4
  %142 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %25, i32 0, i32 2
  %143 = load i32, i32* %14, align 4
  %144 = add nsw i32 %143, 2
  %145 = sext i32 %144 to i64
  %146 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %145
  %147 = load i32, i32* %146, align 4
  store i32 %147, i32* %142, align 4
  %148 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %26, i32 0, i32 0
  %149 = load i32, i32* %15, align 4
  %150 = sext i32 %149 to i64
  %151 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %150
  %152 = load i32, i32* %151, align 4
  store i32 %152, i32* %148, align 4
  %153 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %26, i32 0, i32 1
  %154 = load i32, i32* %15, align 4
  %155 = add nsw i32 %154, 1
  %156 = sext i32 %155 to i64
  %157 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %156
  %158 = load i32, i32* %157, align 4
  store i32 %158, i32* %153, align 4
  %159 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %26, i32 0, i32 2
  %160 = load i32, i32* %15, align 4
  %161 = add nsw i32 %160, 2
  %162 = sext i32 %161 to i64
  %163 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %162
  %164 = load i32, i32* %163, align 4
  store i32 %164, i32* %159, align 4
  %165 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %27, i32 0, i32 0
  %166 = load i32, i32* %16, align 4
  %167 = sext i32 %166 to i64
  %168 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %167
  %169 = load i32, i32* %168, align 4
  store i32 %169, i32* %165, align 4
  %170 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %27, i32 0, i32 1
  %171 = load i32, i32* %16, align 4
  %172 = add nsw i32 %171, 1
  %173 = sext i32 %172 to i64
  %174 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %173
  %175 = load i32, i32* %174, align 4
  store i32 %175, i32* %170, align 4
  %176 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %27, i32 0, i32 2
  %177 = load i32, i32* %16, align 4
  %178 = add nsw i32 %177, 2
  %179 = sext i32 %178 to i64
  %180 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %179
  %181 = load i32, i32* %180, align 4
  store i32 %181, i32* %176, align 4
  %182 = bitcast { i64, i32 }* %28 to i8*
  %183 = bitcast %struct.rgb_t* %20 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %182, i8* align 4 %183, i64 12, i1 false)
  %184 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %28, i32 0, i32 0
  %185 = load i64, i64* %184, align 4
  %186 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %28, i32 0, i32 1
  %187 = load i32, i32* %186, align 4
  %188 = bitcast { i64, i32 }* %29 to i8*
  %189 = bitcast %struct.rgb_t* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %188, i8* align 4 %189, i64 12, i1 false)
  %190 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %29, i32 0, i32 0
  %191 = load i64, i64* %190, align 4
  %192 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %29, i32 0, i32 1
  %193 = load i32, i32* %192, align 4
  %194 = call i32 @is_color(i64 %185, i32 %187, i64 %191, i32 %193)
  %195 = icmp ne i32 %194, 0
  br i1 %195, label %196, label %199

196:                                              ; preds = %8
  %197 = load i32, i32* %17, align 4
  %198 = add nsw i32 %197, 1
  store i32 %198, i32* %17, align 4
  br label %199

199:                                              ; preds = %196, %8
  %200 = bitcast { i64, i32 }* %30 to i8*
  %201 = bitcast %struct.rgb_t* %21 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %200, i8* align 4 %201, i64 12, i1 false)
  %202 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %30, i32 0, i32 0
  %203 = load i64, i64* %202, align 4
  %204 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %30, i32 0, i32 1
  %205 = load i32, i32* %204, align 4
  %206 = bitcast { i64, i32 }* %31 to i8*
  %207 = bitcast %struct.rgb_t* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %206, i8* align 4 %207, i64 12, i1 false)
  %208 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %31, i32 0, i32 0
  %209 = load i64, i64* %208, align 4
  %210 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %31, i32 0, i32 1
  %211 = load i32, i32* %210, align 4
  %212 = call i32 @is_color(i64 %203, i32 %205, i64 %209, i32 %211)
  %213 = icmp ne i32 %212, 0
  br i1 %213, label %214, label %217

214:                                              ; preds = %199
  %215 = load i32, i32* %17, align 4
  %216 = add nsw i32 %215, 1
  store i32 %216, i32* %17, align 4
  br label %217

217:                                              ; preds = %214, %199
  %218 = bitcast { i64, i32 }* %32 to i8*
  %219 = bitcast %struct.rgb_t* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %218, i8* align 4 %219, i64 12, i1 false)
  %220 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %32, i32 0, i32 0
  %221 = load i64, i64* %220, align 4
  %222 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %32, i32 0, i32 1
  %223 = load i32, i32* %222, align 4
  %224 = bitcast { i64, i32 }* %33 to i8*
  %225 = bitcast %struct.rgb_t* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %224, i8* align 4 %225, i64 12, i1 false)
  %226 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %33, i32 0, i32 0
  %227 = load i64, i64* %226, align 4
  %228 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %33, i32 0, i32 1
  %229 = load i32, i32* %228, align 4
  %230 = call i32 @is_color(i64 %221, i32 %223, i64 %227, i32 %229)
  %231 = icmp ne i32 %230, 0
  br i1 %231, label %232, label %235

232:                                              ; preds = %217
  %233 = load i32, i32* %17, align 4
  %234 = add nsw i32 %233, 1
  store i32 %234, i32* %17, align 4
  br label %235

235:                                              ; preds = %232, %217
  %236 = bitcast { i64, i32 }* %34 to i8*
  %237 = bitcast %struct.rgb_t* %23 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %236, i8* align 4 %237, i64 12, i1 false)
  %238 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %34, i32 0, i32 0
  %239 = load i64, i64* %238, align 4
  %240 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %34, i32 0, i32 1
  %241 = load i32, i32* %240, align 4
  %242 = bitcast { i64, i32 }* %35 to i8*
  %243 = bitcast %struct.rgb_t* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %242, i8* align 4 %243, i64 12, i1 false)
  %244 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %35, i32 0, i32 0
  %245 = load i64, i64* %244, align 4
  %246 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %35, i32 0, i32 1
  %247 = load i32, i32* %246, align 4
  %248 = call i32 @is_color(i64 %239, i32 %241, i64 %245, i32 %247)
  %249 = icmp ne i32 %248, 0
  br i1 %249, label %250, label %253

250:                                              ; preds = %235
  %251 = load i32, i32* %17, align 4
  %252 = add nsw i32 %251, 1
  store i32 %252, i32* %17, align 4
  br label %253

253:                                              ; preds = %250, %235
  %254 = bitcast { i64, i32 }* %36 to i8*
  %255 = bitcast %struct.rgb_t* %24 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %254, i8* align 4 %255, i64 12, i1 false)
  %256 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %36, i32 0, i32 0
  %257 = load i64, i64* %256, align 4
  %258 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %36, i32 0, i32 1
  %259 = load i32, i32* %258, align 4
  %260 = bitcast { i64, i32 }* %37 to i8*
  %261 = bitcast %struct.rgb_t* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %260, i8* align 4 %261, i64 12, i1 false)
  %262 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %37, i32 0, i32 0
  %263 = load i64, i64* %262, align 4
  %264 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %37, i32 0, i32 1
  %265 = load i32, i32* %264, align 4
  %266 = call i32 @is_color(i64 %257, i32 %259, i64 %263, i32 %265)
  %267 = icmp ne i32 %266, 0
  br i1 %267, label %268, label %271

268:                                              ; preds = %253
  %269 = load i32, i32* %17, align 4
  %270 = add nsw i32 %269, 1
  store i32 %270, i32* %17, align 4
  br label %271

271:                                              ; preds = %268, %253
  %272 = bitcast { i64, i32 }* %38 to i8*
  %273 = bitcast %struct.rgb_t* %25 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %272, i8* align 4 %273, i64 12, i1 false)
  %274 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %38, i32 0, i32 0
  %275 = load i64, i64* %274, align 4
  %276 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %38, i32 0, i32 1
  %277 = load i32, i32* %276, align 4
  %278 = bitcast { i64, i32 }* %39 to i8*
  %279 = bitcast %struct.rgb_t* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %278, i8* align 4 %279, i64 12, i1 false)
  %280 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %39, i32 0, i32 0
  %281 = load i64, i64* %280, align 4
  %282 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %39, i32 0, i32 1
  %283 = load i32, i32* %282, align 4
  %284 = call i32 @is_color(i64 %275, i32 %277, i64 %281, i32 %283)
  %285 = icmp ne i32 %284, 0
  br i1 %285, label %286, label %289

286:                                              ; preds = %271
  %287 = load i32, i32* %17, align 4
  %288 = add nsw i32 %287, 1
  store i32 %288, i32* %17, align 4
  br label %289

289:                                              ; preds = %286, %271
  %290 = bitcast { i64, i32 }* %40 to i8*
  %291 = bitcast %struct.rgb_t* %26 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %290, i8* align 4 %291, i64 12, i1 false)
  %292 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %40, i32 0, i32 0
  %293 = load i64, i64* %292, align 4
  %294 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %40, i32 0, i32 1
  %295 = load i32, i32* %294, align 4
  %296 = bitcast { i64, i32 }* %41 to i8*
  %297 = bitcast %struct.rgb_t* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %296, i8* align 4 %297, i64 12, i1 false)
  %298 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %41, i32 0, i32 0
  %299 = load i64, i64* %298, align 4
  %300 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %41, i32 0, i32 1
  %301 = load i32, i32* %300, align 4
  %302 = call i32 @is_color(i64 %293, i32 %295, i64 %299, i32 %301)
  %303 = icmp ne i32 %302, 0
  br i1 %303, label %304, label %307

304:                                              ; preds = %289
  %305 = load i32, i32* %17, align 4
  %306 = add nsw i32 %305, 1
  store i32 %306, i32* %17, align 4
  br label %307

307:                                              ; preds = %304, %289
  %308 = bitcast { i64, i32 }* %42 to i8*
  %309 = bitcast %struct.rgb_t* %27 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %308, i8* align 4 %309, i64 12, i1 false)
  %310 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %42, i32 0, i32 0
  %311 = load i64, i64* %310, align 4
  %312 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %42, i32 0, i32 1
  %313 = load i32, i32* %312, align 4
  %314 = bitcast { i64, i32 }* %43 to i8*
  %315 = bitcast %struct.rgb_t* %19 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %314, i8* align 4 %315, i64 12, i1 false)
  %316 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %43, i32 0, i32 0
  %317 = load i64, i64* %316, align 4
  %318 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %43, i32 0, i32 1
  %319 = load i32, i32* %318, align 4
  %320 = call i32 @is_color(i64 %311, i32 %313, i64 %317, i32 %319)
  %321 = icmp ne i32 %320, 0
  br i1 %321, label %322, label %325

322:                                              ; preds = %307
  %323 = load i32, i32* %17, align 4
  %324 = add nsw i32 %323, 1
  store i32 %324, i32* %17, align 4
  br label %325

325:                                              ; preds = %322, %307
  %326 = load i32, i32* %17, align 4
  ret i32 %326
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @is_color(i64 %0, i32 %1, i64 %2, i32 %3) #0 {
  %5 = alloca %struct.rgb_t, align 4
  %6 = alloca { i64, i32 }, align 4
  %7 = alloca %struct.rgb_t, align 4
  %8 = alloca { i64, i32 }, align 4
  %9 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 0
  store i64 %0, i64* %9, align 4
  %10 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %6, i32 0, i32 1
  store i32 %1, i32* %10, align 4
  %11 = bitcast %struct.rgb_t* %5 to i8*
  %12 = bitcast { i64, i32 }* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %11, i8* align 4 %12, i64 12, i1 false)
  %13 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %8, i32 0, i32 0
  store i64 %2, i64* %13, align 4
  %14 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %8, i32 0, i32 1
  store i32 %3, i32* %14, align 4
  %15 = bitcast %struct.rgb_t* %7 to i8*
  %16 = bitcast { i64, i32 }* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %15, i8* align 4 %16, i64 12, i1 false)
  %17 = bitcast %struct.rgb_t* %5 to i8*
  %18 = bitcast %struct.rgb_t* %7 to i8*
  %19 = call i32 @memcmp(i8* %17, i8* %18, i64 12) #6
  %20 = icmp eq i32 %19, 0
  %21 = zext i1 %20 to i32
  ret i32 %21
}

; Function Attrs: nounwind readonly
declare dso_local i32 @memcmp(i8*, i8*, i64) #4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @game_update() #0 {
  %1 = alloca %struct.rgb_t, align 4
  %2 = alloca %struct.rgb_t, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca %struct.rgb_t, align 4
  %15 = alloca i32, align 4
  %16 = alloca { i64, i32 }, align 4
  %17 = alloca { i64, i32 }, align 4
  %18 = alloca { i64, i32 }, align 4
  %19 = alloca { i64, i32 }, align 4
  %20 = bitcast %struct.rgb_t* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 4 %20, i8 0, i64 12, i1 false)
  %21 = bitcast %struct.rgb_t* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %21, i8* align 4 bitcast (%struct.rgb_t* @__const.game_update.green to i8*), i64 12, i1 false)
  store i32 0, i32* %3, align 4
  br label %22

22:                                               ; preds = %163, %0
  %23 = load i32, i32* %3, align 4
  %24 = icmp slt i32 %23, 799
  br i1 %24, label %25, label %166

25:                                               ; preds = %22
  store i32 0, i32* %4, align 4
  br label %26

26:                                               ; preds = %159, %25
  %27 = load i32, i32* %4, align 4
  %28 = icmp slt i32 %27, 599
  br i1 %28, label %29, label %162

29:                                               ; preds = %26
  %30 = load i32, i32* %3, align 4
  %31 = load i32, i32* %4, align 4
  %32 = mul nsw i32 %31, 800
  %33 = add nsw i32 %30, %32
  %34 = mul nsw i32 %33, 3
  store i32 %34, i32* %5, align 4
  %35 = load i32, i32* %3, align 4
  %36 = load i32, i32* %4, align 4
  %37 = add nsw i32 %36, 1
  %38 = mul nsw i32 %37, 800
  %39 = add nsw i32 %35, %38
  %40 = mul nsw i32 %39, 3
  store i32 %40, i32* %6, align 4
  %41 = load i32, i32* %3, align 4
  %42 = load i32, i32* %4, align 4
  %43 = sub nsw i32 %42, 1
  %44 = mul nsw i32 %43, 800
  %45 = add nsw i32 %41, %44
  %46 = mul nsw i32 %45, 3
  store i32 %46, i32* %7, align 4
  %47 = load i32, i32* %3, align 4
  %48 = sub nsw i32 %47, 1
  %49 = load i32, i32* %4, align 4
  %50 = mul nsw i32 %49, 800
  %51 = add nsw i32 %48, %50
  %52 = mul nsw i32 %51, 3
  store i32 %52, i32* %8, align 4
  %53 = load i32, i32* %3, align 4
  %54 = add nsw i32 %53, 1
  %55 = load i32, i32* %4, align 4
  %56 = mul nsw i32 %55, 800
  %57 = add nsw i32 %54, %56
  %58 = mul nsw i32 %57, 3
  store i32 %58, i32* %9, align 4
  %59 = load i32, i32* %3, align 4
  %60 = sub nsw i32 %59, 1
  %61 = load i32, i32* %4, align 4
  %62 = add nsw i32 %61, 1
  %63 = mul nsw i32 %62, 800
  %64 = add nsw i32 %60, %63
  %65 = mul nsw i32 %64, 3
  store i32 %65, i32* %10, align 4
  %66 = load i32, i32* %3, align 4
  %67 = add nsw i32 %66, 1
  %68 = load i32, i32* %4, align 4
  %69 = add nsw i32 %68, 1
  %70 = mul nsw i32 %69, 800
  %71 = add nsw i32 %67, %70
  %72 = mul nsw i32 %71, 3
  store i32 %72, i32* %11, align 4
  %73 = load i32, i32* %3, align 4
  %74 = sub nsw i32 %73, 1
  %75 = load i32, i32* %4, align 4
  %76 = sub nsw i32 %75, 1
  %77 = mul nsw i32 %76, 800
  %78 = add nsw i32 %74, %77
  %79 = mul nsw i32 %78, 3
  store i32 %79, i32* %12, align 4
  %80 = load i32, i32* %3, align 4
  %81 = add nsw i32 %80, 1
  %82 = load i32, i32* %4, align 4
  %83 = sub nsw i32 %82, 1
  %84 = mul nsw i32 %83, 800
  %85 = add nsw i32 %81, %84
  %86 = mul nsw i32 %85, 3
  store i32 %86, i32* %13, align 4
  %87 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %14, i32 0, i32 0
  %88 = load i32, i32* %5, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %89
  %91 = load i32, i32* %90, align 4
  store i32 %91, i32* %87, align 4
  %92 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %14, i32 0, i32 1
  %93 = load i32, i32* %5, align 4
  %94 = add nsw i32 %93, 1
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %95
  %97 = load i32, i32* %96, align 4
  store i32 %97, i32* %92, align 4
  %98 = getelementptr inbounds %struct.rgb_t, %struct.rgb_t* %14, i32 0, i32 2
  %99 = load i32, i32* %5, align 4
  %100 = add nsw i32 %99, 2
  %101 = sext i32 %100 to i64
  %102 = getelementptr inbounds [1440000 x i32], [1440000 x i32]* @board_data, i64 0, i64 %101
  %103 = load i32, i32* %102, align 4
  store i32 %103, i32* %98, align 4
  %104 = load i32, i32* %6, align 4
  %105 = load i32, i32* %7, align 4
  %106 = load i32, i32* %8, align 4
  %107 = load i32, i32* %9, align 4
  %108 = load i32, i32* %10, align 4
  %109 = load i32, i32* %11, align 4
  %110 = load i32, i32* %12, align 4
  %111 = load i32, i32* %13, align 4
  %112 = call i32 @count_living_neighbours(i32 %104, i32 %105, i32 %106, i32 %107, i32 %108, i32 %109, i32 %110, i32 %111)
  store i32 %112, i32* %15, align 4
  %113 = bitcast { i64, i32 }* %16 to i8*
  %114 = bitcast %struct.rgb_t* %14 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %113, i8* align 4 %114, i64 12, i1 false)
  %115 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %16, i32 0, i32 0
  %116 = load i64, i64* %115, align 4
  %117 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %16, i32 0, i32 1
  %118 = load i32, i32* %117, align 4
  %119 = bitcast { i64, i32 }* %17 to i8*
  %120 = bitcast %struct.rgb_t* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %119, i8* align 4 %120, i64 12, i1 false)
  %121 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %17, i32 0, i32 0
  %122 = load i64, i64* %121, align 4
  %123 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %17, i32 0, i32 1
  %124 = load i32, i32* %123, align 4
  %125 = call i32 @is_color(i64 %116, i32 %118, i64 %122, i32 %124)
  %126 = icmp ne i32 %125, 0
  br i1 %126, label %127, label %145

127:                                              ; preds = %29
  %128 = load i32, i32* %15, align 4
  %129 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.1, i64 0, i64 0), i32 %128)
  %130 = load i32, i32* %15, align 4
  %131 = icmp sge i32 %130, 4
  br i1 %131, label %135, label %132

132:                                              ; preds = %127
  %133 = load i32, i32* %15, align 4
  %134 = icmp sle i32 %133, 1
  br i1 %134, label %135, label %144

135:                                              ; preds = %132, %127
  %136 = load i32, i32* %3, align 4
  %137 = load i32, i32* %4, align 4
  %138 = bitcast { i64, i32 }* %18 to i8*
  %139 = bitcast %struct.rgb_t* %1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %138, i8* align 4 %139, i64 12, i1 false)
  %140 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %18, i32 0, i32 0
  %141 = load i64, i64* %140, align 4
  %142 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %18, i32 0, i32 1
  %143 = load i32, i32* %142, align 4
  call void @board_put_pixel(i32 %136, i32 %137, i64 %141, i32 %143)
  br label %144

144:                                              ; preds = %135, %132
  br label %158

145:                                              ; preds = %29
  %146 = load i32, i32* %15, align 4
  %147 = icmp sge i32 %146, 3
  br i1 %147, label %148, label %157

148:                                              ; preds = %145
  %149 = load i32, i32* %3, align 4
  %150 = load i32, i32* %4, align 4
  %151 = bitcast { i64, i32 }* %19 to i8*
  %152 = bitcast %struct.rgb_t* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %151, i8* align 4 %152, i64 12, i1 false)
  %153 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %19, i32 0, i32 0
  %154 = load i64, i64* %153, align 4
  %155 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %19, i32 0, i32 1
  %156 = load i32, i32* %155, align 4
  call void @board_put_pixel(i32 %149, i32 %150, i64 %154, i32 %156)
  br label %157

157:                                              ; preds = %148, %145
  br label %158

158:                                              ; preds = %157, %144
  br label %159

159:                                              ; preds = %158
  %160 = load i32, i32* %4, align 4
  %161 = add nsw i32 %160, 1
  store i32 %161, i32* %4, align 4
  br label %26

162:                                              ; preds = %26
  br label %163

163:                                              ; preds = %162
  %164 = load i32, i32* %3, align 4
  %165 = add nsw i32 %164, 1
  store i32 %165, i32* %3, align 4
  br label %22

166:                                              ; preds = %22
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind willreturn }
attributes #4 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
