//
//  IntegranteInfo.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 21/5/23.
//

import SwiftUI

struct IntegranteInfo: View {
    @EnvironmentObject var integrantesViewModel: IntegrantesViewModel
    @State var isShowingSheet = false
    @State var integrante: Integrante
    
    func getEdad () -> Int {
        let cal = Calendar(identifier: .gregorian)
        guard let years = cal.dateComponents(
            [.year],
            from: integrante.fechaNacimiento,
            to: Date()
        ).year else {
            return 0
        }
        return years
    }
    
    func getEtapaDeberia() -> Etapa? {
        let edad = getEdad()
        guard let etapaDeberia = etapaEdad[edad] else {
            return nil
        }
        
        return etapaDeberia
    }
    
    func isEtapaRight() -> Bool {
        return getEtapaDeberia() == integrante.etapa
    }
    
    func handleEdit() {
        isShowingSheet = true
        integrantesViewModel.integranteNuevo = integrante
    }
    
    func handleCloseSheet() {
        isShowingSheet = false
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text(integrante.nombre)
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }.padding()
                .background(.gray)
            ScrollView {
                
                Group {
                    InfoRow(label: "Nombre de Caza", value: integrante.nombreCaza ?? "")
                    InfoBoolRow(label: "Carnetizado", value: integrante.carnetizado)
                    InfoBoolRow(label: "Promesa", value: integrante.promesa)
                    InfoRow(label: "Fecha Nacimiento", value: integrante.fechaNacimiento.formatted(date: .abbreviated, time: .omitted))
                    InfoRow(label: "Edad", value: "\(getEdad()) años")
                }
                
                HStack {
                    Text("Contacto Emergencia")
                        .foregroundColor(.gray)
                    Spacer()
                    Link(integrante.contactoEmergencia.nombre, destination: URL(string: "tel:\(integrante.contactoEmergencia.numero)") ?? URL(string: "tel:911")!)
                    
                }
                .padding(.horizontal)
                .padding(.top)
                
                DividerAdjusted()
                
                HStack {
                    Text("Seisena")
                        .foregroundColor(.gray)
                    Spacer()
                    InfoSeisena(seisena: integrante.seisena)
                }.padding(.horizontal)
                    .padding(.top)
                
                DividerAdjusted()
                
                Group {
                    HStack {
                        Text("Etapa")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(integrante.etapa.rawValue)")
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    
                    HStack(alignment: .center) {
                        Image(integrante.etapa.rawValue)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(10)
                            .border(isEtapaRight() ? .green : .red, width: 2)
                        
                    }.frame(maxWidth: .infinity)
                    
                    if !isEtapaRight() {
                        if let nuevaEtapa = getEtapaDeberia() {
                            Text("Cambiar a: \(nuevaEtapa.rawValue)")
                                .bold()
                        }
                    }
                    DividerAdjusted()
                }
                
                Group {
                    ForEach(TodasLasEspecialidades.indices, id: \.self) { i in
                        EspecialidadView(integrante: integrante, especialidad: TodasLasEspecialidades[i])
                    }
                }
                
                Spacer()
                
                Button(action: handleEdit) {
                    Text("Editar")
                }.buttonStyle(.bordered)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .sheet(isPresented: $isShowingSheet, onDismiss: handleCloseSheet) {
                IntegranteNuevo(nombreCaza: integrante.nombreCaza ?? "", handleClose: handleCloseSheet)
            }
        }
    }
}

struct IntegranteInfo_Previews: PreviewProvider {
    static let especialidades = Especialidades()
    static let contactoEmergencia = ContactoEmergencia(nombre: "Juanita Perez", numero: "0987607014")
    
    static let integrante = Integrante(nombre: "Aleex", fechaNacimiento: Date(), etapa: .cazador, especialidades: especialidades, contactoEmergencia: contactoEmergencia)
    static var previews: some View {
        IntegranteInfo(integrante: integrante)
    }
}
