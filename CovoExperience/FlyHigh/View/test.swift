import SwiftUI

struct test: View {
    @State var sel: Int = 0

    var body: some View {
        VStack {

            Picker(selection: $sel) {
                Text("Choose an option").tag(0)
                Text("Option 1").tag(1)
                Text("Option 2").tag(2)
            } label: {
                Text("Picker")
            }
            ZStack {
                if sel == 1 {

                    Text("You picked option 1")
                        .frame(width: 200, height: 200)
                        .background(RoundedRectangle(cornerRadius: 20).fill(.gray))
                        .transition(.move(edge: .bottom).combined(with: .opacity))

                } else if sel == 2 {

                    Text("You picked option 2")
                        .frame(width: 200, height: 200)
                        .background(RoundedRectangle(cornerRadius: 20).fill(.gray))
                        .transition(.move(edge: .top).combined(with: .opacity))

                }
            }
            .animation(.easeIn(duration: 1), value: sel)
            Spacer()
        }
        .padding()
    }
}
#Preview{
    test()
}
