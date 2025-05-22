import SwiftUI

struct ContentView: View {
  @State var name: String = ""
  @State var tasks: [String] = ["Primeira tarefa"]
  @State var selectedTaskId: String = ""
  
  func handleInsertNewTask() {
    if !name.isEmpty {
      tasks.append(name)
      name = ""
    }
  }
  
  func delete(taskName: String){
    tasks.removeAll{
      task in task == taskName
    }
  }
  
  func setCurrentTarefaId(task: String){
    selectedTaskId = task
  }
  
  func updateTask(newTask: String){
    if let index = tasks.firstIndex(where: { $0 == selectedTaskId }) {
      tasks[index] = newTask
    }
    
    selectedTaskId = ""
  }
  
  var body: some View {
    VStack {
      Text("Tasker")
      HStack {
        TextField("Informe a tarefa", text: $name)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        Button(action: {
          handleInsertNewTask()
        }){
          Image(systemName: "plus")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(.black)
        }
      }
      
      ForEach(tasks, id: \.self) { task in
        
        HStack {
          Text("\(task)")
          Spacer()
          Button(action: {
            delete(taskName: task)
          }) {
            Image(systemName:"trash")
              .foregroundColor(.black)
          }
        }.padding(.top, 25)
        
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
